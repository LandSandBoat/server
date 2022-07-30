---------------------------------------------------------------
-- Gardening Module to remove Results based on Era by Expansion
---------------------------------------------------------------

UPDATE gardening_results
SET weight = 0 WHERE resultid IN 
(
-- Chains of Promathia
--34,  -- Eggplant
--647, -- Sprig Of Misareaux Parsley
--664, -- Holy Basil
--667, -- Vanilla 

-- Treasures of Aht Urghan
--2423, -- Gregarious Worm
--2426, -- Clump of Garidav Wildgrass
--2428, -- Zegham Carrot
--2429, -- Azouph Greens
--2434, -- Vomp Carrot
--2437, -- Sharug Greens
--2440, -- Clump Of Tokopekko Wildgrass
--2442, -- Cupid Worm
--2444, -- Cupid Worm

-- Wings of the Goddess
--702, -- Burdock

-- Out of Era (2012+)
716 -- Winterflower
)
