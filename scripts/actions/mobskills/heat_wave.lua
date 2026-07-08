-----------------------------------
-- Heat Wave
-- Family: Bomb
-- Description : A fiery wave that inflicts a potent Burn to targets in the area.
-- Notes: Used by Bombs (Fire Type) in COP zones and expansions beyond. TOAU has a more powerful Burn effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    -- The effect power scaling is not perfectly linear and there are large level range gaps where there are no mobs that use this skill.
    -- The table below makes sure we get the correct power from retail capture and interpolates the gaps with the known values.
    -- The interpolated gaps will likely only come into play if someone makes custom content.
    -- The spreadsheet below shows where the level range gaps are as well as level specific power.
    -- https://docs.google.com/spreadsheets/d/12O11XhwBp18nA7XEMx-MIYPxxdlwpXkWxMIIBzo1QqU/edit?gid=1354203546#gid=1354203546

    local effectPower =
    {
    -- { maxLevel, power }
        { 5,  1 },
        { 10, 2 },
        { 15, 3 },
        { 19, 4 },
        { 25, 5 },
        { 28, 6 },
        { 31, 7 },
        { 35, 8 },
        { 40, 9 },
        { 44, 10 },
        { 47, 11 },
        { 55, 12 },
        { 57, 13 },
        { 61, 14 },
        { 65, 15 },
        { 70, 16 },
        { 74, 17 },
        { 79, 18 },
        { 80, 19 },
    }

    local function getMobSkillPower(level)
        for _, table in ipairs(effectPower) do
            if level <= table[1] then
                return table[2]
            end
        end

        return 19 -- No data past level 80
    end

    -- This is the power for COP era Bombs.
    local power = getMobSkillPower(mob:getMainLvl())

    -- TOAU Bombs and Big Bomb use different power scaling
    if skill:getID() == xi.mobSkill.HEAT_WAVE_2 then
        power = math.floor(math.max(1, (mob:getMainLvl() - 5) / 2))
    end

    local effectTable =
    {
        [1] = { effectId = xi.effect.BURN, power = power, tick = 3, duration = 180, tier = 1, },
    }

    return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
end

return mobskillObject
