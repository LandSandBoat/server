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

xi.dynamis.onFightApocDRG = function(mob, target)
    local apoc = GetMobByID(mob:getZone():getLocalVar("Apocalyptic Beast"))
    if os.time() >= apoc:getLocalVar("next2hrTime") then
        DespawnMob(mob:getID())
    end
end

xi.dynamis.onPetDeath = function(mob)
    if mob:getMaster():getMainJob() == xi.job.BST then
        mob:getMaster():setLocalVar("[jobSpecial]ability_", 710)
    end
end

return m
