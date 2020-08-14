---------------------------------------------
-- Healing Breath III
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

   -- Info:
   -- Breath Formula: http://www.bluegartr.com/threads/108543-Wyvern-Breath-Testing?p=5357018&viewfull=1#post5357018
   -- Healing Breath Results: http://images2.wikia.nocookie.net/__cb20080714061150/ffxi/images/3/32/Healingbreathgraph.jpg (Assume Wyvern has 991 HP)

   -- TODO:
   -- Wyvern Exp Bonus is +6% HP per 200 exp gained until 1, 000 exp cap, granting a max 30% (0.3 works in the formula)
      -- Exp bonus wears off at zone, dismiss, etc, and shouldn't be handled here, as it also adds to other stats.
   -- Wyvern HP or HP% gear has no effect (Not handled here)

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
