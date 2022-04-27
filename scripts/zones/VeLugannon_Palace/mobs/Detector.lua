-----------------------------------
-- Area: VeLugannon Palace
--  Mob: Detector
-----------------------------------
require("scripts/globals/regimes")
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("petCount", 1)
end

entity.onMobFight = function(mob, target)
    local caretaker = GetMobByID(mob:getID() + 1)
    local petCount = mob:getLocalVar("petCount")
    local popTime = GetServerVariable("[POP]Steam_Cleaner")
    local steamcleaner = GetMobByID(ID.mob.STEAM_CLEANER)

    -- Summons a Caretaker every 15 seconds.
    -- TODO: Casting animation for before summons. When he spawns them isn't exactly retail accurate.
    --       Should be ~10s to start cast, and another ~5 to finish.
    -- Detectors can also still spawn the Caretakers while sleeping, moving, etc.
    -- Maximum number of pets Detector can spawn is 5
    if petCount <= 5 and mob:getBattleTime() % 15 < 3 and mob:getBattleTime() > 3 and popTime <= os.time() and not caretaker:isSpawned() and not steamcleaner:isSpawned() and math.random(1,10) >= 7 then
        steamcleaner:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
        steamcleaner:spawn()
        steamcleaner:updateEnmity(target)
        mob:setLocalVar("petCount", petCount + 1)
    elseif petCount <= 5 and mob:getBattleTime() % 15 < 3 and mob:getBattleTime() > 3 and not caretaker:isSpawned() and not steamcleaner:isSpawned() then
        caretaker:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
        caretaker:spawn()
        caretaker:updateEnmity(target)
        mob:setLocalVar("petCount", petCount + 1)
    end

    -- make sure pet has a target
    if caretaker:getCurrentAction() == xi.act.ROAMING then
        caretaker:updateEnmity(target)
    end
end

entity.onMobDisengage = function(mob)
    local caretakerId = mob:getID() + 1

    mob:resetLocalVars()

    if GetMobByID(caretakerId):isSpawned() then
        DespawnMob(caretakerId)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 743, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local caretakerId = mob:getID() + 1

    mob:resetLocalVars()

    if GetMobByID(caretakerId):isSpawned() then
        DespawnMob(caretakerId)
    end
end

return entity
