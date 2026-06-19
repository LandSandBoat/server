-----------------------------------
-- Area: Lebros Cavern
-- Evade and Escape
-----------------------------------
local entity = {}
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------

local function allSwitchesTriggered (instance)
    for i, switchID in pairs(ID.npc.SWITCHES) do
        local switch = GetNPCByID(switchID, instance)

        if switch and switch:getLocalVar('triggered') == 0 then
            return false
        end
    end

    return true
end

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if npc:getAnimationSub() == 0 then
        if npc:getLocalVar('triggered') == 0 then
            npc:setLocalVar('triggered', 1)

            npc:timer(3 * 60 * 1000, function(npcArg)
                if instance and npcArg:getAnimationSub() == 0 then
                    npcArg:setLocalVar('triggered', 0)
                end
            end)

            if allSwitchesTriggered(instance) then
                for i, switchID in pairs(ID.npc.SWITCHES) do
                    local switch = GetNPCByID(switchID, instance)

                    if switch then
                        switch:setAnimationSub(1)
                        switch:resetLocalVars()
                    end
                end

                player:messageSpecial(ID.text.SWITCHES_GLOWING)
                instance:setProgress(1)
            else
                player:messageSpecial(ID.text.SWITCH_LIGHTS_UP)
            end
        elseif npc:getLocalVar('triggered') == 1 then
            player:messageSpecial(ID.text.SWITCH_WARNING)
        end
    else
        player:messageSpecial(ID.text.SWITCHES_NOTHING)
    end
end

return entity
