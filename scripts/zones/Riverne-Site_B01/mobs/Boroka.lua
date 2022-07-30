-----------------------------------
-- Area: Riverne - Site B01
--   NM: Boroka
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.FASTCAST, 20)
    mob:addMod(xi.mod.SILENCERES, 80)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.SOUL_VOICE, cooldown = 120, hpp = math.random(85, 95)}, -- Can use Soul Voice multiple times
        },
    })
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Always follows up any TP move with Hoof Volley
    local skillId = skill:getID()

    if skillId ~= 1330 then
        mob:useMobAbility(1330)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.BOROKA_BELEAGUERER)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21-24 hour respawn
end

return entity
