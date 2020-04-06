module ApplicationHelper
    def login_helper
        if current_user.is_a?(GuestUser)
            (link_to "Registration", new_user_registration_path, method: :get) +
            "<br>".html_safe +
            (link_to "Login", new_user_session_path, method: :get)
        else
            link_to "Logout", destroy_user_session_path, method: :delete
        end
    end

    def source_helper(layout_name)
        if session[:source]
            greeting = "Thanks for visiting me from #{session[:source]} and you are on the #{layout_name} layout"
            content_tag(:p, greeting, class: "source-greeting")
        end
    end
end
