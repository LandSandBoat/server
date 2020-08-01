-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Defender
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("petCount", 1)
end

function onMobFight(mob, target)
    local auraGear = GetMobByID(mob:getID() + 1)
    local petCount = mob:getLocalVar("petCount")

    -- Summons an Aura Gear every 15 seconds.
    -- TODO: Casting animation for before summons. When he spawns them isn't exactly retail accurate.
    -- Defenders can also still spawn the Aura Gears while sleeping, etc.
    -- Maximum number of pets Defender can spawn is 5
    if petCount <= 5 and mob:getBattleTime() % 15 < 3 and mob:getBattleTime() > 3 and not auraGear:isSpawned() then
        auraGear:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
        auraGear:spawn()
        auraGear:updateEnmity(target)
        mob:setLocalVar("petCount", petCount + 1)
    end

    -- make sure pet has a target
    if auraGear:getCurrentAction() == tpz.act.ROAMING then
        auraGear:updateEnmity(target)
    end
end

function onMobDisengage(mob)
    local auraGearId = mob:getID() + 1

    mob:resetLocalVars()

    if GetMobByID(auraGearId):isSpawned() then
        DespawnMob(auraGearId)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 749, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn( mob )
    local auraGearId = mob:getID() + 1

    mob:resetLocalVars()

    if GetMobByID(auraGearId):isSpawned() then
        DespawnMob(auraGearId)
    end
end
