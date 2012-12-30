module ContextMenuShift
	class IssueHooks < Redmine::Hook::ViewListener
		render_on :view_issues_context_menu_end, :partial => "context_menus/shift_issues"
	end
end
