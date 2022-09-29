-----------------------------------
-- Area: Sky 2.0
--   NM: Kirin
-----------------------------------
local ID = require("scripts/zones/Escha_RuAun/IDs")
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function( mob )
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.WIND_MEVA, -64) -- Todo: Move to mob_resists.sql
    mob:setMod(xi.mod.SILENCERES, 999)
    mob:setMod(xi.mod.STUNRES, 999)
    mob:setMod(xi.mod.BINDRES, 999)
    mob:setMod(xi.mod.GRAVITYRES, 999)
    mob:addStatusEffect(xi.effect.REGEN, 60, 3, 0)
    mob:setUntargetable(false)
    mob:setDropID(3989)
end

entity.onMobFight = function( mob, target )
    local byakko = 17961580
    local genbu  = 17961583
    local seiryu = 17961586
    local suzaku = 17961589
-- Upgrade
    local kouryu = 17961577
-- Second wave of gods
    local healthPoolLow = math.random(51, 70)

-- Turn over to Kouryu
    if mob:getHPP() < 50 then
        mob:setHP(0)
        GetMobByID(kouryu):setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(kouryu):updateClaim(mob:getTarget())
    end

-- GOD logic
    if mob:getLocalVar("evenmoregods") == 1 then
        return
    elseif mob:getHPP() <= healthPoolLow then -- RNG gods
        GetMobByID(byakko):setSpawn(mob:getXPos() + 2, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(byakko):updateEnmity(mob:getTarget())
        GetMobByID(genbu):setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(genbu):updateEnmity(mob:getTarget())
        mob:setLocalVar("evenmoregods", 1) -- prevent repop
        end

    if mob:getLocalVar("gods") == 1 then
        return
    elseif mob:getLocalVar("gods") == 0 then -- Will spawn right away
        GetMobByID(seiryu):setSpawn(mob:getXPos() + 2, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(seiryu):updateEnmity(mob:getTarget())
        GetMobByID(suzaku):setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(suzaku):updateEnmity(mob:getTarget())
        mob:setLocalVar("gods", 1) -- prevent repop
        end
-- END God logic

-- KIRIN REFLECT LOGIC
    mob:addListener("MAGIC_TAKE", "KIRIN_REFLECT", function(target, caster, spell)
    if
        spell:tookEffect() and
        (caster:isPC() or caster:isPet()) and
        (spell:getSpellGroup() ~= xi.magic.spellGroup.BLUE or target:getLocalVar("[kirim]reflect_blue_magic") == 1)
    then
        target:setLocalVar("[kirin]spellToMimic", spell:getID()) -- which spell to mimic
        target:setLocalVar("[kirin]castWindow", os.time() + 30) -- after thirty seconds, will stop attempting to mimic
        target:setLocalVar("[kirin]castTime", os.time() + 6) -- enforce a delay between original spell, and mimic spell.
    end
    end)

    mob:addListener("COMBAT_TICK", "KIRIN_REFLECT_CTICK", function(mob)
        local spellToMimic = mob:getLocalVar("[kirin]spellToMimic")
        local castWindow = mob:getLocalVar("[kirin]castWindow")
        local castTime = mob:getLocalVar("[kirin]castTime")
        local osTime = os.time()

            if spellToMimic > 0 and osTime > castTime and castWindow > osTime and not mob:hasStatusEffect(xi.effect.SILENCE) then
                mob:castSpell(spellToMimic, target)
                mob:setLocalVar("[kirin]spellToMimic", 0)
                mob:setLocalVar("[kirin]castWindow", 0)
                mob:setLocalVar("[kirin]castTime", 0)
            elseif spellToMimic == 0 or osTime > castWindow then
                mob:setLocalVar("[kirin]spellToMimic", 0)
                mob:setLocalVar("[kirin]castWindow", 0)
                mob:setLocalVar("[kirin]castTime", 0)
        end
    end)

    mob:addListener("DISENGAGE", "KIRIN_DISENGAGE", function(mob)
        mob:setLocalVar("[kirin]spellToMimic", 0)
        mob:setLocalVar("[kirin]castWindow", 0)
        mob:setLocalVar("[kirin]castTime", 0)
    end)
-- END REFLECT LOGIC
    for i = 17961580, 17961580 + 9 do
        local god = GetMobByID(i)
            if (god:getCurrentAction() == xi.act.ROAMING) then
            god:updateEnmity(target)
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE)
end

entity.onMobDeath = function(mob, player, isKiller)
    for i = 17961580, 17961580 + 9 do
        DespawnMob(i)
    end
end

entity.onMobDespawn = function( mob )
    for i = 17961580, 17961580 + 9 do
        DespawnMob(i)
    end
end

return entity
