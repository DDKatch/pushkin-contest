class TaskSender
  include Sidekiq::Worker

  def perform(user_id, task_id)
    logger = Logger.new('log/task_sender')

    user = User.find(user_id)
    task = Task.find(task_id)

    uri = URI.parse(user.url)
    parameters = {id: task.id, question: task.question, level: task.level}.to_json
    Net::HTTP.post_form(uri, parameters)

    # TODO: add some logs here
  end

end
