local Components = script.Parent.Parent.Parent.Parent
local Packages = Components.Parent.Packages

local Roact = require(Packages.Roact)
local RoactRouter = require(Packages.RoactRouter)

local e = Roact.createElement

local Theming = require(Components.Theming)

local Component = Roact.Component:extend("NavButton")

Component.defaultProps = {
	path = nil,
	state = nil,

	label = "Button",
	position = nil, -- "start" or "end"

	layoutOrder = nil,
}

function Component:render()
	return Theming.useTheme(function(theme)
		return e(RoactRouter.Context.Consumer, {
			render = function(routing)
				return e("ImageButton", {
					BackgroundColor3 = theme.Accent,
					BackgroundTransparency = 1,
					LayoutOrder = self.props.layoutOrder,
					Size = UDim2.fromScale(1, 1),
					Image = "rbxassetid://5038702297",
					ImageColor3 = theme.Accent,
					-- ImageRectSize = Vector2.new(512, 1024),
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(512, 512, 512, 512),
					SliceScale = 6 / 512,

					[Roact.Event.MouseButton1Click] = function()
						routing.history:replace(
							self.props.path, self.props.state
						)
					end,
				}, {
					e("UIListLayout", {
						Padding = UDim.new(),
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					}),

					e("UIPadding", {
						PaddingBottom = UDim.new(0, 4),
						PaddingLeft = UDim.new(0, 8),
						PaddingRight = UDim.new(0, 8),
						PaddingTop = UDim.new(0, 4),
					}),

					e("TextLabel", {
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundTransparency = 1,
						Font = Enum.Font.GothamSemibold,
						Text = self.props.label,
						TextColor3 = Color3.new(1, 1, 1),
						TextSize = 14,
						TextWrapped = true,
					}),
				})
			end,
		})
	end)
end

return Component
