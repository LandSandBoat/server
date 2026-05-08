-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Fire Golem
-- BCNM: Idol Thoughts
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 75)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
end

-- Golems use TP moves at the same time if possible. Crystal Weapon gets mapped to the respective element, and Thunder/Ice Break gets mapped to the element the other Golems are neutral/weak to.
entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.ICE_BREAK_1,
        xi.mobSkill.CRYSTAL_RAIN_1,
        xi.mobSkill.CRYSTAL_WEAPON_FIRE_1,
    }

    local mimicTable =
    {
        [mob:getID() + 1] = { crystalWeapon = xi.mobSkill.CRYSTAL_WEAPON_WATER_1, elementalBreak = xi.mobSkill.ICE_BREAK_1     }, -- Water Golem
        [mob:getID() + 2] = { crystalWeapon = xi.mobSkill.CRYSTAL_WEAPON_WIND_1,  elementalBreak = xi.mobSkill.THUNDER_BREAK_1 }, -- Wind Golem
        [mob:getID() + 3] = { crystalWeapon = xi.mobSkill.CRYSTAL_WEAPON_STONE_1, elementalBreak = xi.mobSkill.THUNDER_BREAK_1 }, -- Earth Golem
    }

    local chosenSkill = skillList[math.random(1, #skillList)]

    for golemID, mimicSkills in pairs(mimicTable) do
        local golem = GetMobByID(golemID)
        local mimicSkill = chosenSkill

        if chosenSkill == xi.mobSkill.CRYSTAL_WEAPON_FIRE_1 then
            mimicSkill = mimicSkills.crystalWeapon
        elseif chosenSkill == xi.mobSkill.ICE_BREAK_1 then
            mimicSkill = mimicSkills.elementalBreak
        end

        if
            golem and
            golem:isAlive() and
            golem:getTP() > 1000 and
            golem:checkDistance(target) <= 15
        then
            golem:useMobAbility(mimicSkill)
        end
    end

    return chosenSkill
end

return entity
