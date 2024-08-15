-----------------------------------
-- Eclosion
-- Morphs a Wamouracampa into a Wamoura
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:timer(4000, function(mobArg)
        mobArg:setStatus(xi.status.INVISIBLE)
        local mobID = mobArg:getID()
        DespawnMob(mobID)
        DisallowRespawn(mobID, true)

        local wamoura = GetMobByID(mobID + 1)
        wamoura:setSpawn(mobArg:getXPos(), mobArg:getYPos(), mobArg:getZPos())
        SpawnMob(mobID + 1)

        wamoura:addListener('DESPAWN', 'WAMOURA_DESPAWN', function(wamouraMob)
            GetMobByID(mobID):setRespawnTime(GetMobRespawnTime(mobID))
            DisallowRespawn(mobID, false)
        end)
    end)

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
