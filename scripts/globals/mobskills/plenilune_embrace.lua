---------------------------------------------
-- Plenilune_Embrace
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    -- Saw no math at any online source describing mob version, only player version..
    -- Someone needs to go figure out what the retail math is.
end

return mobskill_object
