-----------------------------------
-- Area: Dynamis - Xarcabard
--   NM: Yang
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local ying = GetMobByID(ID.mob.YING)
        if not ying then
            return
        end

        if ying:isAlive() then
            return
        end

        local director = GetNPCByID(ID.npc.DYNAMIS_LORD_DIRECTOR)
        if not director then
            return
        end

        -- Both dragons defeated, schedule next summoning time.
        director:setLocalVar('[Timer]YingYang', GetSystemTime() + 240)

        local realDynamisLord = GetMobByID(director:getLocalVar('[Lord]RealId'))
        if not realDynamisLord then
            return
        end

        if realDynamisLord:isAlive() then
            realDynamisLord:messageText(realDynamisLord, ID.text.DYNAMIS_LORD_DIALOGUE + 8) -- Immortal drakes, defeated by these insignificant beings? How amusing.
        end
    end
end

return entity
