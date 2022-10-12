-- Reloads party list
cmdprops = { permission = 0, parameters = ""}

function onTrigger(player)
    player:reloadParty()
end