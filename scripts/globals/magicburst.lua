xi = xi or {}
xi.magicburst = xi.magicburst or {}

local matches = -- [element id][resonance id]
{
--    1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17
--    N  T  C  L  S  R  D  I  I  G  D  F  F  L  D  L  D
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, -- (1) NONE
    { 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0 }, -- (2) FIRE
    { 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1 }, -- (3) ICE
    { 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0 }, -- (4) WIND
    { 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1 }, -- (5) EARTH
    { 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0 }, -- (6) THUNDER
    { 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1 }, -- (7) WATER
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0 }, -- (8) LIGHT
    { 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1 }, -- (9) DARK
    -- Blue mage spells.  Included for the sake of completeness
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, -- (10) BLU - Physical Blunt
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, -- (11) BLU - Physical Hand-to-Hand
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, -- (12) BLU - Physical Piercing
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, -- (13) BLU - Physical Slashing
}

-- Returns a boolean if the spell's element matches the resonace given
local function doesSpellElementMatchResonance(ele, resonance)
    local isMatch = matches[ele + 1][resonance:getPower() + 1]
    return (isMatch ~= nil and isMatch > 0)
end

xi.magicburst.formMagicBurst = function(element, target)
    local resonance = target:getStatusEffect(xi.effect.SKILLCHAIN)

    if
        resonance ~= nil and
        resonance:getTier() > 0
    then
        if doesSpellElementMatchResonance(element, resonance) then
            return resonance:getTier(), resonance:getSubPower()
        end
    end

    return 0, 0
end

-- Returns a boolean if the element matches the skillchain property given
xi.magicburst.doesElementMatchWeaponskill = function(ele, SCProp)
    local isMatch = matches[ele + 1][SCProp + 1]
    return (isMatch ~= nil and isMatch > 0)
end
