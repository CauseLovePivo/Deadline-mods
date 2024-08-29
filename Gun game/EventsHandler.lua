shared.EventsTable = {
    kill_player = function(player)
        player.explode()
    end
}


on_client_event:Connect(function(plrname, args)
    local player = get_player(plrname)
    for i,v in player do
        print(i," ",v)
    end
    shared.EventsTable[args[1]](player)
end)
