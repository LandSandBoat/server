-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Mamool Ja Strapper (BST)
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-- mixins = { require('scripts/mixins/master') }
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
--[[
    local mobID    = mob:getID()
    local instance = mob:getInstance()

    if mobID >= 17076360 then
        mob:setPet(GetMobByID(mobID + 2, instance))
    else
        mob:setPet(GetMobByID(mobID + 4, instance))
    end
]]
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance then
            local stage    = instance:getStage()

            if stage == 3 then
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
