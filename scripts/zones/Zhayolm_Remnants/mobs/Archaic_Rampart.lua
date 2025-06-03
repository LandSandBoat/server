-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Archaic Rampart
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
mixins = { require('scripts/mixins/families/rampart') }
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local mobID = mob:getID()

    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    mob:setMobMod(xi.mobMod.ROAM_TURNS, 0)
    mob:setLocalVar('spawnCount', 1)
    if
        utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_RAMPART, 7, 9)) or
        utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_RAMPART, 3, 5))
    then
        mob:setLocalVar('spawnOffset', 2)
        mob:setAggressive(false)
        mob:setMobMod(xi.mobMod.NO_LINK, 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance then
            local stage    = instance:getStage()
            local mobID    = mob:getID()

            if stage == 3 then
                local poroggo    = ID.mob.POROGGO_MADAME[3]
                local stageBoss  = GetMobByID(mobID, instance)
                local southGroup =
                {
                    utils.slice(ID.mob.MAMOOL_JA_ZENIST, 6, 12),
                    utils.slice(ID.mob.MAMOOL_JA_SPEARMAN, 2, 8),
                    utils.slice(ID.mob.MAMOOL_JA_STRAPER, 1, 7),
                    utils.slice(ID.mob.MAMOOL_JA_BOUNDER, 2, 4)
                }
                local northGroup =
                {
                    utils.slice(ID.mob.MAMOOL_JA_SAVANT, 2, 11),
                    utils.slice(ID.mob.MAMOOL_JA_SOPHIST, 1, 10),
                    utils.slice(ID.mob.MAMOOL_JA_MIMICKER, 1, 12),
                }

                xi.salvage.spawnTempChest(mob, { rate = 1000 })

                if xi.salvage.groupKilled(instance, southGroup) then
                    if stageBoss and stageBoss:getLocalVar('spawned') == 0 then
                        SpawnMob(poroggo, instance):setPos(380, -4, 389)
                        stageBoss:setDropID(3409)
                        stageBoss:setLocalVar('spawned', 1)
                    end
                elseif xi.salvage.groupKilled(instance, northGroup) then
                    if stageBoss and stageBoss:getLocalVar('spawned') == 0 then
                        SpawnMob(poroggo, instance):setPos(300, -4, 526)
                        stageBoss:setDropID(3408)
                        stageBoss:setMaxHP(10150)
                        stageBoss:updateHealth()
                        stageBoss:setLocalVar('spawned', 1)
                    end
                end
            elseif
                instance:getStage() == 5 and
                mobID ~= ID.mob.ARCHAIC_RAMPART[6] and
                mobID ~= ID.mob.ARCHAIC_RAMPART[10]
            then
                xi.salvage.spawnTempChest(mob, { rate = 1000 })
            end
        end
    end
end

return entity
