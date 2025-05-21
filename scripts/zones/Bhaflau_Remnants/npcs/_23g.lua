-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 2nd Floor 2nd Door East Wing, opens SE section, locks NE Section
-- !pos 420 -2 200
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getLocalVar('unSealed') == 1 then
        player:startEvent(300)
    else
        player:messageSpecial(ID.text.DOOR_IS_SEALED)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 300 and option == 1 then
        local instance = npc:getInstance()

        if instance and xi.salvage.onDoorOpen(npc) then
            xi.salvage.sealDoors(instance, ID.npc.DOOR_2_NE_ENTRANCE)
            xi.salvage.unsealDoors(instance, ID.npc.DOOR_2_SE_EXIT)
            local mobs =
            {
                utils.slice(ID.mob.SULFUR_SCORPION, 16, 22),
                ID.mob.TROLL_SMELTER[6],
                ID.mob.TROLL_STONEWORKER[3],
                ID.mob.TROLL_CAMEIST[3],
            }
            xi.salvage.spawnGroup(instance, mobs)
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
