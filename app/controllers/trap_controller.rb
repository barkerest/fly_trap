class TrapController < ApplicationController

  def self.trapped_data
    @trapped_data ||= {}
  end

  def self.reset_trapped_data
    ret = @trapped_data
    @trapped_data = {}
    ret || {}
  end

  def index
    q_who = request.remote_ip
    q_what = "/#{params[:trigger]}"
    q_when = Time.now

    TrapController.trapped_data[q_what] ||= []
    TrapController.trapped_data[q_what] << { requested_by: q_who, requested_at: q_when }

    Rails.logger.warn "trapped { requested_by: #{q_who.inspect}, requested_at: #{q_when.inspect}, requested_path: #{q_what.inspect} }"

    render nothing: true, status: :not_found
  end

  def ping
    tmp_data = TrapController.reset_trapped_data
    output = {}
    output[:unique_paths] = tmp_data.keys.count
    output[:total_requests] = 0
    by_requestor = { }
    tmp_data.each do |k,v|
      output[:total_requests] += v.count
      v.each do |r|
        by_requestor[r[:requested_by]] ||= []
        by_requestor[r[:requested_by]] << { requested_path: k, requested_at: r[:requested_at] }
      end
    end
    output[:unique_requestors] = by_requestor.keys.count
    output[:worst_requestor] = nil
    output[:worst_count] = 0
    by_requestor.each do |k,v|
      if v.count > output[:worst_count]
        output[:worst_requestor] = k
        output[:worst_count] = v.count
      end
    end

    output[:timestamp] = Time.now.strftime('%Y-%m-%d %H:%M:%S')

    render json: output.to_json
  end

end
