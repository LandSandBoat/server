-----------------------------------
-- Area: Konschtat Highlands
--   NM: Ghillie Dhu
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/mobs")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- For its TP drain melee.
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)

    -- Hits especially hard for his level, even by NM standards.
    mob:addMod(xi.mod.ATT, 50) -- May need adjustment along with cmbDmgMult in mob_pools.sql
end

entity.onMobRoam = function(mob)
    -- Fairly sure he shouldn't be storing up max TP while idle.
    if mob:getMod(xi.mod.REGAIN) ~= 0 then
        mob:setMod(xi.mod.REGAIN, 0)
    end
end

entity.onMobFight = function(mob, target)
    -- Guesstimating the regain scales from 1-100,
    -- nobody has the excact values but it scales with HP.
    local tp = (100 - mob:getHPP()) * 0.5
    if mob:getMod(xi.mod.REGAIN) ~= utils.clamp(tp, 1, 100) then
        mob:setMod(xi.mod.REGAIN, utils.clamp(tp, 1, 100))
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN, { power = math.random(10, 30) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 204)
    -- I think he still counts for the FoV page? Most NM's do not though.
    xi.regime.checkRegime(player, mob, 81, 1, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(3600, 4200)) -- 60~70 min repop.
end

return entity
