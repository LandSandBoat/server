-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 1st floor West entrance
-- Sets up mobs spawning, locks opposite side and unlocks exit to West wing
-- !pos 360 14 -500
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

        if instance and xi.salvage.onDoorOpen(npc, 1, 2) then
            local random = math.random(100)
            local unsealed =
            {
                ID.npc.DOOR_1_WEST_EXIT_1,
                ID.npc.DOOR_1_WEST_EXIT_2,
                ID.npc.DOOR_1_WEST_EXIT_3,
            }

            xi.salvage.unsealDoors(instance, unsealed)
            xi.salvage.sealDoors(instance, ID.npc.DOOR_1_EAST_ENTRANCE)
            local mobs =
            {
                ID.mob.WAMOURACAMPA,
                utils.slice(ID.mob.BIFRONS, 8, 14),
                utils.slice(ID.mob.TROLL_LAPIDARIST, 1, 2),
            }
            xi.salvage.spawnGroup(instance, mobs)
            if random >= 50 then
                if random >= 75 then
                    instance:setLocalVar('dormantArea', 3)
                    GetMobByID(ID.mob.MAD_BOMBER, instance):setSpawn(260, 16, -291, 62)
                    GetNPCByID(ID.npc.DORMANT_RAMPART[1], instance):setPos(260, 16, -282, 62)
                else
                    instance:setLocalVar('dormantArea', 4)
                    GetMobByID(ID.mob.MAD_BOMBER, instance):setSpawn(229, 16, -460, 125)
                    GetNPCByID(ID.npc.DORMANT_RAMPART[1], instance):setPos(237, 16, -460, 125)
                end

                SpawnMob(ID.mob.MAD_BOMBER, instance)
            end
        else
            player:messageSpecial(ID.text.DOOR_IS_SEALED)
        end
    end
end

return entity
