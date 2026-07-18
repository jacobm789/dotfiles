local count = ya.sync(function() return #cx.tabs end)

local function entry()
	if count() < 2 then
		ya.emit("quit", {})
		return
	end

	local yes = ya.confirm {
		pos = { "center", w = 62, h = 10 },
		title = "Quit?",
		body = ui.Text("There are multiple tabs open. Are you sure you want to quit?"):wrap(ui.Wrap.YES),
	}

	if yes then
		ya.emit("quit", {})
	end
end

return { entry = entry }
