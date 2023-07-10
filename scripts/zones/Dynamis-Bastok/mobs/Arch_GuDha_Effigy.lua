-----------------------------------
-- CatsEyeXI Dynamis 2.0
-- Area: Dynamis - Bastok
--  Mob: Arch_GuDha_Effigy
-- !Spawnmob 17539312
-- !pos -17.9628 -1.2508 -128.7250 186
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage")
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
