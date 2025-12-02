-----------------------------------
-- Unlocking a Myth: Paladin
-----------------------------------
--  Log ID: JEUNO, Quest ID: UNLOCKING_A_MYTH_PALADIN
--  NPC: Zalsuhm:  !pos -32.990,5.901,-117.458 244
-----------------------------------
require('scripts/quests/jeuno/helpers')
-----------------------------------

local quest = xi.jeuno.helpers.UnlockingAMyth:new(xi.job.PLD)

return quest
