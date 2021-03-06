module QuestionsHelper
  # Returns a dynamic path based on the provided parameters
  def sti_question_path(type = "question", question = nil, action = nil)
    send "#{format_sti(action, type, question)}_path", question
  end

  def format_sti(action, type, question)
    action || question ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end

  def format_action(action)
    action ? "#{action}_" : ""
  end

  def form_name(type)
    type == "Question"? "form" : type.underscore+"_form"
  end

  def type_as_badge(question)
    if question.type == "MultipleChoice"
      '<span class="badge badge-primary">Multiple choice</span>'.html_safe
    elsif question.type == "MultipleSelect"
      '<span class="badge badge-info">Multiple select</span>'.html_safe
    end
  end
end
