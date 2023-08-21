-----------------------------------
-- Plenilune_Embrace
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Saw no math at any online source describing mob version, only player version..
    -- Someone needs to go figure out what the retail math is.
end

return mobskillObject
