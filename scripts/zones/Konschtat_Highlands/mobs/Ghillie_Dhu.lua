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

function onMobInitialize(mob)
    -- For its TP drain melee.
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)

    -- Hits especially hard for his level, even by NM standards.
    mob:addMod(tpz.mod.ATT, 50) -- May need adjustment along with cmbDmgMult in mob_pools.sql
end

function onMobRoam(mob)
    -- Fairly sure he shouldn't be storing up max TP while idle.
    if mob:getMod(tpz.mod.REGAIN) ~= 0 then
        mob:setMod(tpz.mod.REGAIN, 0)
    end
end

function onMobFight(mob, target)
    -- Guesstimating the regain scales from 1-100,
    -- nobody has the excact values but it scales with HP.
    local TP = (100 - mob:getHPP()) * 0.5
    if mob:getMod(tpz.mod.REGAIN) ~= utils.clamp(TP, 1, 100) then
        mob:setMod(tpz.mod.REGAIN, utils.clamp(TP, 1, 100))
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.TP_DRAIN, {power = math.random(10, 30)})
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 204)
    -- I think he still counts for the FoV page? Most NM's do not though.
    tpz.regime.checkRegime(player, mob, 81, 1, tpz.regime.type.FIELDS)
    tpz.tutorial.onMobDeath(player)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(3600, 4200)) -- 60~70 min repop.
end
