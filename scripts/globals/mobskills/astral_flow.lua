-----------------------------------
-- Astral Flow
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
require("scripts/globals/msg")
require("modules/era/lua_dynamis/globals/era_dynamis_spawning")
-----------------------------------
local mobskill_object = {}

xi = xi or {}
xi.astralflow = xi.astralflow or {}
xi.astralflow.avatarOffsets =
{
    [17444883] = 3, -- Vermilion-eared Noberry
    [17453078] = 3, -- Duke Dantalian
    [17453085] = 3, -- Duke Dantalian
    [17453092] = 3, -- Duke Dantalian
    [17506670] = 5, -- Kirin
}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.USES)
    local mobID = mob:getID()
    local avatar = 0

    if mob:isInDynamis() then
        local mobInfo = xi.dynamis.mobList[mob:getZoneID()][mob:getZone():getLocalVar((string.format("MobIndex_%s", mob:getID())))]

        if mobInfo ~= nil and mobInfo.info[2] == "Apocalyptic Beast" then
            if mob:getLocalVar("ASTRAL_FLOW") == 1 then
                skill:setMsg(xi.msg.basic.NONE)
                return xi.effect.NONE
            end

            xi.dynamis.spawnDynamicPet(target, mob, xi.job.SMN)
        elseif mobInfo ~= nil and mobInfo.info[2] == "Dagourmarche" then
            xi.dynamis.spawnDynamicPet(target, mob, xi.job.SMN)
        end
    else
        if xi.astralflow.avatarOffsets[mobID] then
            avatar = mobID + xi.astralflow.avatarOffsets[mobID]
        else
            avatar = mobID + 2 -- default offset
        end

        if not GetMobByID(avatar):isSpawned() then
            GetMobByID(avatar):setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
            SpawnMob(avatar):updateEnmity(mob:getTarget())
        end
    end

    return xi.effect.ASTRAL_FLOW
end

return mobskill_object
