---------------------------------------------
--   Used to Allow for Dynamic Entities    --
---------------------------------------------
---------------------------------------------
--        Module Required Scripts          --
---------------------------------------------
require("modules/era/lua_dynamis/globals/era_dynamis_spawning")
require("modules/module_utils")
require("scripts/globals/mobskills/astral_flow")
require("scripts/globals/mobskills/call_wyvern")
require("scripts/globals/mobskills")
require("scripts/globals/msg")
---------------------------------------------
local m = Module:new("era_pet_skills")

xi = xi or {}
xi.dynamis = xi.dynamis or {}

xi.dynamis.onFightApocDRG = function(mob, target)
    if not mob:getMaster() or mob:getMaster():getHP() == 0 then
        DespawnMob(mob:getID())
    end

    if mob:getMaster() and (os.time() >= mob:getMaster():getLocalVar("next2hrTime")) then
        DespawnMob(mob:getID())
    end
end

xi.dynamis.onRoamApocDRG = function(mob)
    if not mob:getMaster() or mob:getMaster():getHP() == 0 then
        DespawnMob(mob:getID())
    end

    if mob:getMaster() and mob:getMaster():getTarget() then
        mob:updateEnmity(mob:getMaster():getTarget())
    end

    if mob:getMaster() and (os.time() >= mob:getMaster():getLocalVar("next2hrTime")) then
        DespawnMob(mob:getID())
    end
end

-- For mobs with multiple pets - we are at risk for unxpected behavior due to pet AI relying on master's AI state
-- Most if not all core actions assume a single pet and take action only on the single known pet
-- As an interim fix - despawn pets when the master is dead.
xi.dynamis.onFightMultiPet = function(mob, target)
    if not mob:getMaster() or mob:getMaster():isDead() then
        DespawnMob(mob:getID())
    end
end

xi.dynamis.onRoamMultiPet = function(mob)
    if not mob:getMaster() or mob:getMaster():isDead() then
        DespawnMob(mob:getID())
    end
end

xi.dynamis.onPetDeath = function(mob)
    if mob:getMaster():getMainJob() == xi.job.BST then
        mob:getMaster():setLocalVar("[jobSpecial]ability_", 710)
    end
end

return m
