---------------------------------------------
--   Used to Allow for Dynamic Entities    --
---------------------------------------------
---------------------------------------------
--        Module Required Scripts          --
---------------------------------------------
require("scripts/globals/dynamis")
require("modules/era/lua/dynamis/globals/era_dynamis")
require("modules/era/lua/dynamis/globals/era_dynamis_spawning")
require("modules/module_utils")
---------------------------------------------
local m = Module:new("era_pet_skills")

m:addOverride("xi.globals.mobskills.call_wyvern.onMobWeaponSkill", function(target, mob, skill)
    local mobName = xi.dynamis.mobList[mob:getZoneID()][mob:getZone():getLocalVar((string.format("MobIndex_%s", mob:getID())))].info[2]
    if mob:getLocalVar("CALL_WYVERN") == 1 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end

    if mob:isInDynamis() then
        if mobName == "Apocalyptic Beast" then
            for i = 5, 1, -1 do
                xi.dynamis.spawnDynamicPet(target, mob, xi.job.DRG)
            end
        else
            xi.dynamis.spawnDynamicPet(target, mob, xi.job.DRG)
        end
    else
        mob:spawnPet()
    end

    skill:setMsg(xi.msg.basic.NONE)

    return 0

end)

m:addOverride("xi.globals.mobskills.astral_flow.onMobWeaponSkill", function(target, mob, skill)
    skill:setMsg(xi.msg.basic.USES)
    local mobID = mob:getID()
    local avatar = 0
    local mobName = xi.dynamis.mobList[mob:getZoneID()][mob:getZone():getLocalVar((string.format("MobIndex_%s", mob:getID())))].info[2]

    if mob:getLocalVar("ASTRAL_FLOW") == 1 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end

    if mob:isInDynamis() then
        if mobName == "Apocalyptic Beast" then
            xi.dynamis.spawnDynamicPet(target, mob, xi.job.SMN)
        elseif mobName == "Dagourmarche" then
            xi.dynamis.spawnDynamicPet(target, mob, xi.job.SMN)
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
    end

    return xi.effect.ASTRAL_FLOW

end)

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

m:addOverride("xi.globals.mobskills.mijin_gakure.onMobWeaponSkill", function(target, mob, skill)
    print("I'm HERE")
    if mob:getLocalVar("MIJIN_GAKURE") == 1 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end

    local dmgmod = 1
    local hpmod = skill:getMobHPP() / 100
    local basePower = (mob:getFamily() == 335) and 4 or 6 -- Maat has a weaker (4) Mijin than usual (6)
    local power = hpmod * 10 + basePower
    local baseDmg = mob:getWeaponDmg() * power
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, baseDmg, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    return dmg
end)

return m
