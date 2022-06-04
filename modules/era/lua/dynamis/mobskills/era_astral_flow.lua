---------------------------------------------
--               Astral Flow               --
-- Used to Allow for Dynamic Avatar Entity --
---------------------------------------------
---------------------------------------------
--        Module Required Scripts          --
---------------------------------------------
require("scripts/globals/dynamis")
require("modules/era/lua/dynamis/globals/era_dynamis")
require("modules/era/lua/dynamis/globals/era_dynamis_spawning")
require("modules/module_utils")
require("scripts/globals/mobskills/astral_flow")

local m = Module:new("era_astral_flow")

m:addOverride("xi.globals.mobskills.astral_flow.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.USES)
    local mobID = mob:getID()
    local avatar = 0

    if mob:getZone():getType() == xi.zoneType.DYNAMIS then
        if mob:getName() == "Apocalyptic_Beast" then
            xi.dynamis.spawnDynamicPet(target, mob, xi.job.SMN)
            return xi.effect.ASTRAL_FLOW
        elseif mob:getName() == "Dagourmarche" then
            xi.dynamis.spawnDynamicPet(target, mob, xi.job.SMN)
            return xi.effect.ASTRAL_FLOW
        else
            return xi.effect.ASTRAL_FLOW
        end
    else
        if avatarOffsets[mobID] then
            avatar = mobID + avatarOffsets[mobID]
        else
            avatar = mobID + 2 -- default offset
        end
    
        if not GetMobByID(avatar):isSpawned() then
            GetMobByID(avatar):setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
            SpawnMob(avatar):updateEnmity(mob:getTarget())
        end

        return xi.effect.ASTRAL_FLOW

    end
end)

return m
