---------------------------------------------
-- Healing Breath II
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(pet, target, skill, action)

   -- TODO:
   -- Healing Breath I and II should have lower multipliers.  They'll need to be corrected if the multipliers are ever found.  Don't want to over-correct right now.

   ---------- Deep Breathing ----------
   -- 0 for none
   -- 50 for first merit
   -- 5 for each merit after the first
   -- TODO: 5 per merit for augmented AF2 (10663 *w/ augment*)
    local master = pet:getMaster()
    local deep = 0
   if (pet:hasStatusEffect(tpz.effect.MAGIC_ATK_BOOST) == true) then
      deep = 50 + (master:getMerit(tpz.merit.DEEP_BREATHING)-1)*5
      pet:delStatusEffect(tpz.effect.MAGIC_ATK_BOOST)
   end

    local gear = master:getMod(tpz.mod.WYVERN_BREATH) -- Master gear that enhances breath

    local tp = math.floor(pet:getTP()/200)/1.165 -- HP only increases for every 20% TP
   pet:setTP(0)

    local base = math.floor(((45+tp+gear+deep)/256)*(pet:getMaxHP())+42)
   if (target:getHP()+base > target:getMaxHP()) then
      base = target:getMaxHP() - target:getHP() --cap it
   end
   skill:setMsg(tpz.msg.basic.JA_RECOVERS_HP)
   target:addHP(base)
   return base
end
