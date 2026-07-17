-----------------------------------
-- Area: Dynamis-Xarcabard
--  NPC: ??? (qm0)
-- Note: Spawns Dynamis Lord / Arch Dynamis Lord
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_XARCABARD]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Prevents Dynamis Lord from being spawned if any of IDs are up.
    for mobId = ID.mob.DYNAMIS_LORD, ID.mob.DYNAMIS_LORD + 5 do
        local dynamisLord = GetMobByID(mobId)

        if dynamisLord and dynamisLord:isSpawned() then
            return
        end
    end

    -- Clear any state left over from a fight that ended without a kill.
    npc:setLocalVar('[Lord]RealId', 0)
    npc:setLocalVar('[2hour]Index', 0)
    npc:setLocalVar('[2hour]Time', 0)
    npc:setLocalVar('[Timer]YingYang', 0)
    npc:setLocalVar('[Timer]Clones', 0)

    xi.dynamis.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.qmOnTrigger(player, npc)
end

return entity
