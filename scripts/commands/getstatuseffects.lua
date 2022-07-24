require("scripts/globals/status")
require("scripts/globals/msg")

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    local target = player:getCursorTarget()
    if target == nil then
        return
    end

    local effects = target:getStatusEffects()
    for k, v in pairs(effects) do
        player:PrintToPlayer(string.format("%s: %s", k, v:getPower()))
    end
    
end