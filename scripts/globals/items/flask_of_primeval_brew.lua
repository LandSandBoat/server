-----------------------------------------
-- ID: 5853
-- Item: Flask of Primeval Brew
-- Status Effect: 3 minutes, All Races
-----------------------------------------
-- HP +9000
-- MP +9000
-- Strength +900
-- Dexterity +900
-- Vitality +900
-- Agility +900
-- Intelligence +900
-- Mind +900
-- Charisma +900
-- Attack +9000
-- Defense +9000
-- Accuracy +1000
-- Evasion +1000
-- Magic Attack Bonus +900
-- Regen +300
-- Refresh +300
-- Regain +50
-- Ranged Accuracy +1000
-- Ranged Attack +9000

require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    if (target:hasStatusEffect(tpz.effect.TRANSCENDENCY)) then
        return 523
    else
        return 0
    end
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.TRANSCENDENCY, 1, 0, 180)
end
