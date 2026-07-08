-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Mamool Ja Sophist
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance then
            local stage    = instance:getStage()

            if stage == 3 then
                local group =
                {
                    utils.slice(ID.mob.MAMOOL_JA_SAVANT, 2, 11),
                    utils.slice(ID.mob.MAMOOL_JA_SOPHIST, 1, 10),
                    utils.slice(ID.mob.MAMOOL_JA_MIMICKER, 1, 12),
                    ID.mob.ARCHAIC_RAMPART[2]
                }

                if xi.salvage.groupKilled(instance, group) then
                    local id       = ID.mob.POROGGO_MADAME[3]
                    local stageBoss = GetMobByID(id, instance)
                    if stageBoss and stageBoss:getLocalVar('spawned') == 0 then
                        SpawnMob(id, instance):setPos(300, -4, 526)
                        stageBoss:setDropID(3408)
                        stageBoss:setMaxHP(10150)
                        stageBoss:updateHealth()
                        stageBoss:setLocalVar('spawned', 1)
                    end
                end
            end
        end
    end
end

return entity
