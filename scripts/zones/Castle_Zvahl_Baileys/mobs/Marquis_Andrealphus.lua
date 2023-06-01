-----------------------------------
-- Area: Castle Zvahl Baileys
-- NM: Marquis Andrealphus
-- Quest: Better the Demon you Know
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local ID = require('scripts/zones/Castle_Zvahl_Baileys/IDs')
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob)
    -- Blood Weapon Timer
    mob:setLocalVar("timer", os.time() + 180)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar("timer") < os.time() then
        mob:setLocalVar("timer", os.time() + 180)
        mob:useMobAbility(695)
    end

    -- Escape player with hate out of zone
    if mob:getHPP() < 75 and mob:getLocalVar("hpControl1") == 0 then
        mob:showText(mob, ID.text.BEGONE)
        mob:setLocalVar("hpControl1", 1)
        mob:useMobAbility(307, target)

    elseif mob:getHPP() < 25 and mob:getLocalVar("hpControl2") == 0 then
        mob:showText(mob, ID.text.BEGONE)
        mob:setLocalVar("hpControl2", 1)
        mob:useMobAbility(307, target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
