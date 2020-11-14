require("scripts/globals/status")

SC_NONE          =  0 -- Lv0 None
SC_TRANSFIXION   =  1 -- Lv1 Light
SC_COMPRESSION   =  2 -- Lv1 Dark
SC_LIQUEFACTION  =  3 -- Lv1 Fire
SC_SCISSION      =  4 -- Lv1 Earth
SC_REVERBERATION =  5 -- Lv1 Water
SC_DETONATION    =  6 -- Lv1 Wind
SC_INDURATION    =  7 -- Lv1 Ice
SC_IMPACTION     =  8 -- Lv1 Thunder
SC_GRAVITATION   =  9 -- Lv2 Dark & Earth
SC_DISTORTION    = 10 -- Lv2 Water & Ice
SC_FUSION        = 11 -- Lv2 Fire & Light
SC_FRAGMENTATION = 12 -- Lv2 Wind & Thunder
SC_LIGHT         = 13 -- Lv3 Fire, Light, Wind, Thunder
SC_DARKNESS      = 14 -- Lv3 Dark, Earth, Water, Ice
SC_LIGHT_II      = 15 -- Lv4 Light
SC_DARKNESS_II   = 16 -- Lv4 Darkness

local matches = -- [element id][resonance id]
{
--   1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17
--   N  T  C  L  S  R  D  I  I  G  D  F  F  L  D  L  D
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- ( 1) NONE
    {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0}, -- ( 2) FIRE
    {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1}, -- ( 3) ICE
    {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0}, -- ( 4) WIND
    {0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1}, -- ( 5) EARTH
    {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0}, -- ( 6) THUNDER
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1}, -- ( 7) WATER
    {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0}, -- ( 8) LIGHT
    {0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1}, -- ( 9) DARK
    -- Blue mage spells.  Included for the sake of completeness
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- (10) BLU - Physical Blunt
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- (11) BLU - Physical Hand-to-Hand
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- (12) BLU - Physical Piercing
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, -- (13) BLU - Physical Slashing
}

-- Returns a boolean if the spell's element matches the resonace given
function doesSpellElementMatchResonance(ele, resonance)
    isMatch = matches[ele + 1][resonance:getPower() + 1]
    return (isMatch ~= nil and isMatch > 0)
end

-- Returns the burst level for a spell / target combination
function FormMagicBurst(ele, target)
    local resonance = target:getStatusEffect(tpz.effect.SKILLCHAIN)
    if (resonance ~= nil and resonance:getTier() > 0) then -- Resonance exists, ignore it if its tier 0
        if (doesSpellElementMatchResonance(ele, resonance) == true) then
            return resonance:getTier(), resonance:getSubPower()
        end
    end -- if resonance

    return 0, 0
end

function MobFormMagicBurst(element, target)
    local resonance = target:getStatusEffect(tpz.effect.SKILLCHAIN)

    if (resonance ~= nil and resonance:getTier() > 0) then -- Resonance exists, ignore it if its tier 0
        if (doesMobSpellElementMatchResonance(element, resonance) == true) then
            return resonance:getTier(), resonance:getSubPower()
        end
    end -- if resonance

    return 0, 0
end

function doesMobSpellElementMatchResonance(element, resonance)
    isMatch = matches[element + 1][resonance:getPower() + 1]
    return (isMatch ~= nil and isMatch > 0)
end

-- Returns a boolean if the element matches the skillchain property given
function doesElementMatchWeaponskill(ele, SCProp)
    isMatch = matches[ele + 1][SCProp + 1]
    return (isMatch ~= nil and isMatch > 0)
end
