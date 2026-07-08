-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 3rd Floor NE Door
-- !pos -280 0 -260
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()
    if
        instance and
        instance:getStage() == 3 and
        instance:getProgress() == 3
    then
        player:startEvent(300)
    else
        player:messageSpecial(ID.text.DOOR_IS_SEALED)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 300 and option == 1 then
        local instance = npc:getInstance()

        if instance and xi.salvage.onDoorOpen(npc, nil, 5) then
            xi.salvage.unsealDoors(instance, ID.npc.DOOR_3_NORTH_CENTER)
            local mobs =
            {
                utils.slice(ID.mob.TROLL_STONEWORKER, 12, 13),
                ID.mob.TROLL_SMELTER[10],
                ID.mob.TROLL_CAMEIST[10],
                ID.mob.TROLL_IRONWORKER[11],
                utils.slice(ID.mob.TROLL_ENGRAVER, 12, 13),
                utils.slice(ID.mob.TROLL_GEMOLOGIST, 7, 8),
                ID.mob.TROLL_LAPIDARIST[5],
            }
            xi.salvage.spawnGroup(instance, mobs)
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
