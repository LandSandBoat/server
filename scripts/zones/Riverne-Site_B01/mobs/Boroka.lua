-----------------------------------
-- Area: Riverne - Site B01
--   NM: Boroka
-- !pos -365.921 -31.255 486.367 29
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.FASTCAST, 20)
    mob:addMod(xi.mod.SILENCERES, 80)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.SOUL_VOICE, cooldown = 120, hpp = 100 }, -- Can use Soul Voice multiple times
        },
    })
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Always follows up any TP move with Hoof Volley
    local skillId = skill:getID()

    if skillId ~= 696 and skillId ~= 1330 then
        mob:useMobAbility(1330)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BOROKA_BELEAGUERER)
end

entity.onMobDespawn = function(mob, player, optParams)
    xi.mob.nmTODPersist(mob, math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
