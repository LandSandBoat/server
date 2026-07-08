-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Mamool Ja Zenist
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    -- only first floor mobs should have higher delay
    local instance = mob:getInstance()

    if instance then
        local stage    = instance:getStage()
        if stage == 1 then
            mob:setDelay(480)
            mob:setMod(xi.mod.ATT, 60)
            mob:setMod(xi.mod.MAIN_DMG_RATING, -32)
            mob:setMod(xi.mod.INT, -25)
            mob:setMod(xi.mod.MATT, -10)
        elseif stage == 2 then
            mob:addListener('TREASUREPOOL', 'ZENIST_ADDED_DROPS', function(mobArg, target, itemid)
                target:addTreasure(itemid, mobArg)
            end)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance then
            local stage    = instance:getStage()
            local progress = instance:getProgress()

            if stage == 1 then
                xi.salvage.spawnTempChest(mob,
                {
                    rate = 1000,
                    itemID_1 = xi.item.DUSTY_POTION,
                    itemAmount_1 = 18
                })
                mob:setDropID(0)
            elseif stage == 2 then
                xi.salvage.spawnTempChest(mob,
                {
                    rate = 1000,
                    itemID_1 = xi.item.DUSTY_ETHER,
                    itemAmount_1 = 10
                })
                if progress == 2 then
                    instance:setLocalVar('stageComplete', 2)
                    GetNPCByID(ID.npc.SLOT, instance):setStatus(xi.status.NORMAL)
                    GetNPCByID(ID.npc.SOCKET, instance):setStatus(xi.status.NORMAL)
                    xi.salvage.unsealDoors(instance, { ID.npc.DOOR_2_1, ID.npc.DOOR_2_2, ID.npc.DOOR_2_3, ID.npc.DOOR_2_4 })
                    xi.salvage.spawnGroup(instance, utils.slice(ID.mob.DRACO_LIZARD, 9, 16))
                    xi.salvage.spawnGroup(instance, utils.slice(ID.mob.WYVERN, 9, 16))
                    xi.salvage.spawnGroup(instance, utils.slice(ID.mob.WYVERN, 1, 8))
                    xi.salvage.onDoorOpen(GetNPCByID(ID.npc.DOOR_2_1, instance), nil, 5)
                    xi.salvage.onDoorOpen(GetNPCByID(ID.npc.DOOR_2_2, instance))
                    xi.salvage.onDoorOpen(GetNPCByID(ID.npc.DOOR_2_3, instance))
                    xi.salvage.onDoorOpen(GetNPCByID(ID.npc.DOOR_2_4, instance))
                end
            elseif stage == 3 then
                local group =
                {
                    utils.slice(ID.mob.MAMOOL_JA_ZENIST, 6, 12),
                    utils.slice(ID.mob.MAMOOL_JA_SPEARMAN, 2, 8),
                    utils.slice(ID.mob.MAMOOL_JA_STRAPER, 1, 7),
                    utils.slice(ID.mob.MAMOOL_JA_BOUNDER, 2, 4),
                    ID.mob.ARCHAIC_RAMPART[1]
                }

                if xi.salvage.groupKilled(instance, group) then
                    local id       = ID.mob.POROGGO_MADAME[3]
                    local stageBoss = GetMobByID(id, instance)
                    if stageBoss and stageBoss:getLocalVar('spawned') == 0 then
                        SpawnMob(id, instance):setPos(380, -4, 389)
                        stageBoss:setDropID(3408)
                        stageBoss:setLocalVar('spawned', 1)
                    end
                end
            end
        end
    end
end

return entity
