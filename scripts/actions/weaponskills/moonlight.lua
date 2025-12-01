-----------------------------------
-- Moonlight
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    -- Use club skill (11 == xi.skill.CLUB, but constant is nicer if available)
    local clubSkill = player:getSkillLevel(11)

    -- Base amount scales with skill.
    -- At ~276 club, base ~= 138
    local base = clubSkill / 2

    -- TP tiers: 1000, 2000, 3000
    -- 1k  -> 1.2x
    -- 2k  -> 1.8x
    -- 3k+ -> 2.4x
    local tpStep = math.floor(tp / 1000)
    if tpStep < 1 then
        tpStep = 1
    elseif tpStep > 3 then
        tpStep = 3
    end

    local tpMultiplier = 0
    if tpStep == 1 then
        tpMultiplier = 1.2
    elseif tpStep == 2 then
        tpMultiplier = 1.8
    else -- 3
        tpMultiplier = 2.4
    end

    local damagemod = math.floor(base * tpMultiplier * xi.settings.main.WEAPON_SKILL_POWER)

    -- Return format kept the same as your original:
    -- (hits, tpHits, crit, "damage"/MP amount)
    return 1, 0, false, damagemod
end

return weaponskillObject
