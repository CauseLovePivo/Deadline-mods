iris:Connect(function()
	iris.Window({"My Second Window"})
		if iris.Button({"respawn me"}).clicked() then
			fire_server("respawn")
		end
        
        if iris.Button({"get my stats"}).clicked() then
			fire_server("get_my_stats")
		end

	iris.End()
end)