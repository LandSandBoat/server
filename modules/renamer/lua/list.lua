require("scripts/globals/zone")
local list =
{
    [xi.zone.SOUTH_GUSTABERG] =
    {
        { 17215489, "1" }, -- Stone Crab
        { 17215490, "2" }, -- Sand Crab
        { 17215491, "3" }, -- Land Crab
        { 17215492, "4" }, -- Mole Crab
        { 17215493, "5" }, -- Passage Crab
        { 17215494, "Bubbly Bernard Esq" }, -- Bubbly Bernie
        { 17215495, "7" }, -- Huge Hornet
        { 17215496, "8" }, -- Huge Hornet
        { 17215497, "9" }, -- Huge Hornet
        { 17215498, "10" }, -- Huge Hornet
        { 17215499, "11" }, -- Huge Hornet
        { 17215500, "12" }, -- Huge Hornet
        { 17215501, "13" }, -- Huge Hornet
        { 17215502, "14" }, -- Tunnel Worm
        { 17215503, "15" }, -- Tunnel Worm
        { 17215504, "16" }, -- Tunnel Worm
        { 17215505, "17" }, -- Tunnel Worm
        { 17215506, "18" }, -- Ding Bats
        { 17215507, "19" }, -- Ding Bats
        { 17215508, "20" }, -- Ding Bats
        { 17215509, "21" }, -- Ding Bats
        { 17215510, "22" }, -- Huge Hornet
        { 17215511, "23" }, -- Huge Hornet
        { 17215512, "24" }, -- Huge Hornet
        { 17215513, "25" }, -- Huge Hornet
        { 17215514, "26" }, -- Huge Hornet
        { 17215515, "27" }, -- Huge Hornet
        { 17215516, "28" }, -- Tunnel Worm
        { 17215517, "29" }, -- Tunnel Worm
        { 17215518, "30" }, -- Tunnel Worm
        { 17215519, "31" }, -- Tunnel Worm
        { 17215520, "32" }, -- Ding Bats
        { 17215521, "33" }, -- Ding Bats
        { 17215522, "34" }, -- Ding Bats
        { 17215523, "35" }, -- Ding Bats
        { 17215524, "36" }, -- Huge Hornet
        { 17215525, "37" }, -- Huge Hornet
        { 17215526, "38" }, -- Huge Hornet
        { 17215527, "39" }, -- Huge Hornet
        { 17215528, "40" }, -- Huge Hornet
        { 17215529, "41" }, -- Huge Hornet
        { 17215530, "42" }, -- Tunnel Worm
        { 17215531, "43" }, -- Tunnel Worm
        { 17215532, "44" }, -- Tunnel Worm
        { 17215533, "45" }, -- Ding Bats
        { 17215534, "46" }, -- Ding Bats
        { 17215535, "47" }, -- Ding Bats
        { 17215536, "48" }, -- Huge Hornet
        { 17215537, "49" }, -- Huge Hornet
        { 17215538, "50" }, -- Huge Hornet
        { 17215539, "51" }, -- Huge Hornet
        { 17215540, "52" }, -- Huge Hornet
        { 17215541, "53" }, -- Huge Hornet
        { 17215542, "54" }, -- Huge Hornet
        { 17215543, "55" }, -- Tunnel Worm
        { 17215544, "56" }, -- Tunnel Worm
        { 17215545, "57" }, -- Tunnel Worm
        { 17215546, "58" }, -- Ding Bats
        { 17215547, "59" }, -- Ding Bats
        { 17215548, "60" }, -- Ding Bats
        { 17215549, "61" }, -- Ding Bats
        { 17215550, "62" }, -- Maneating Hornet
        { 17215551, "63" }, -- Maneating Hornet
        { 17215552, "64" }, -- Maneating Hornet
        { 17215553, "65" }, -- Stone Eater
        { 17215554, "66" }, -- Stone Eater
        { 17215555, "67" }, -- Ornery Sheep
        { 17215556, "68" }, -- Ornery Sheep
        { 17215557, "69" }, -- Goblin Thug
        { 17215558, "70" }, -- Ding Bats
        { 17215559, "71" }, -- Ding Bats
        { 17215560, "72" }, -- Fledermaus
        { 17215561, "73" }, -- Fledermaus
        { 17215562, "74" }, -- Black Wolf
        { 17215563, "75" }, -- Maneating Hornet
        { 17215564, "76" }, -- Maneating Hornet
        { 17215565, "77" }, -- Maneating Hornet
        { 17215566, "78" }, -- Stone Eater
        { 17215567, "79" }, -- Ornery Sheep
        { 17215568, "80" }, -- Ornery Sheep
        { 17215569, "81" }, -- Goblin Thug
        { 17215570, "82" }, -- Goblin Thug
        { 17215571, "83" }, -- Ding Bats
        { 17215572, "84" }, -- Ding Bats
        { 17215573, "85" }, -- Fledermaus
        { 17215574, "86" }, -- Black Wolf
        { 17215575, "87" }, -- Maneating Hornet
        { 17215576, "88" }, -- Maneating Hornet
        { 17215577, "89" }, -- Stone Eater
        { 17215578, "90" }, -- Ornery Sheep
        { 17215579, "91" }, -- Ornery Sheep
        { 17215580, "92" }, -- Goblin Thug
        { 17215581, "93" }, -- Goblin Thug
        { 17215582, "94" }, -- Ding Bats
        { 17215583, "95" }, -- Fledermaus
        { 17215584, "96" }, -- Fledermaus
        { 17215585, "97" }, -- Black Wolf
        { 17215586, "98" }, -- Maneating Hornet
        { 17215587, "99" }, -- Maneating Hornet
        { 17215588, "100" }, -- Stone Eater
        { 17215589, "101" }, -- Ornery Sheep
        { 17215590, "102" }, -- Ornery Sheep
        { 17215591, "103" }, -- Goblin Thug
        { 17215592, "104" }, -- Goblin Weaver
        { 17215593, "105" }, -- Ding Bats
        { 17215594, "106" }, -- Fledermaus
        { 17215595, "107" }, -- Fledermaus
        { 17215596, "108" }, -- Black Wolf
        { 17215597, "109" }, -- Maneating Hornet
        { 17215598, "110" }, -- Maneating Hornet
        { 17215599, "111" }, -- Stone Eater
        { 17215600, "112" }, -- Ornery Sheep
        { 17215601, "113" }, -- Ornery Sheep
        { 17215602, "114" }, -- Goblin Thug
        { 17215603, "115" }, -- Goblin Weaver
        { 17215604, "116" }, -- Ding Bats
        { 17215605, "117" }, -- Fledermaus
        { 17215606, "118" }, -- Fledermaus
        { 17215607, "119" }, -- Black Wolf
        { 17215608, "120" }, -- Maneating Hornet
        { 17215609, "121" }, -- Maneating Hornet
        { 17215610, "122" }, -- Stone Eater
        { 17215611, "123" }, -- Ornery Sheep
        { 17215612, "124" }, -- Ornery Sheep
        { 17215613, "125" }, -- Carnero
        { 17215614, "126" }, -- Goblin Thug
        { 17215615, "127" }, -- Goblin Weaver
        { 17215616, "128" }, -- Ding Bats
        { 17215617, "129" }, -- Fledermaus
        { 17215618, "130" }, -- Black Wolf
        { 17215619, "131" }, -- Enchanted Bones
        { 17215620, "132" }, -- Enchanted Bones
        { 17215621, "133" }, -- Maneating Hornet
        { 17215622, "134" }, -- Maneating Hornet
        { 17215623, "135" }, -- Stone Eater
        { 17215624, "136" }, -- Ornery Sheep
        { 17215625, "137" }, -- Ornery Sheep
        { 17215626, "138" }, -- Carnero
        { 17215627, "139" }, -- Goblin Thug
        { 17215628, "140" }, -- Goblin Weaver
        { 17215629, "141" }, -- Ding Bats
        { 17215630, "142" }, -- Fledermaus
        { 17215631, "143" }, -- Black Wolf
        { 17215632, "144" }, -- Enchanted Bones
        { 17215633, "145" }, -- Enchanted Bones
        { 17215634, "146" }, -- Maneating Hornet
        { 17215635, "147" }, -- Maneating Hornet
        { 17215636, "148" }, -- Stone Eater
        { 17215637, "149" }, -- Stone Eater
        { 17215638, "150" }, -- Ornery Sheep
        { 17215639, "151" }, -- Goblin Thug
        { 17215640, "152" }, -- Goblin Thug
        { 17215641, "153" }, -- Ding Bats
        { 17215642, "154" }, -- Fledermaus
        { 17215643, "155" }, -- Black Wolf
        { 17215644, "156" }, -- Enchanted Bones
        { 17215645, "157" }, -- Ornery Sheep
        { 17215646, "158" }, -- Ornery Sheep
        { 17215647, "159" }, -- Black Wolf
        { 17215648, "160" }, -- Ornery Sheep
        { 17215649, "161" }, -- Ornery Sheep
        { 17215650, "162" }, -- Black Wolf
        { 17215651, "163" }, -- Stone Eater
        { 17215652, "164" }, -- Stone Eater
        { 17215653, "165" }, -- Stone Eater
        { 17215654, "166" }, -- Stone Eater
        { 17215655, "167" }, -- Stone Eater
        { 17215656, "168" }, -- Stone Eater
        { 17215657, "169" }, -- Stone Eater
        { 17215658, "170" }, -- Stone Eater
        { 17215659, "171" }, -- Rock Lizard
        { 17215660, "172" }, -- Walking Sapling
        { 17215661, "173" }, -- Walking Sapling
        { 17215662, "174" }, -- Vulture
        { 17215663, "175" }, -- Vulture
        { 17215664, "176" }, -- Stone Eater
        { 17215665, "177" }, -- Stone Eater
        { 17215666, "178" }, -- Stone Eater
        { 17215667, "179" }, -- Stone Eater
        { 17215668, "180" }, -- Stone Eater
        { 17215669, "181" }, -- Stone Eater
        { 17215670, "182" }, -- Stone Eater
        { 17215671, "183" }, -- Stone Eater
        { 17215672, "184" }, -- Rock Lizard
        { 17215673, "185" }, -- Walking Sapling
        { 17215674, "186" }, -- Walking Sapling
        { 17215675, "187" }, -- Vulture
        { 17215676, "188" }, -- Vulture
        { 17215677, "189" }, -- Young Quadav
        { 17215678, "190" }, -- Young Quadav
        { 17215679, "191" }, -- Stone Eater
        { 17215680, "192" }, -- Stone Eater
        { 17215681, "193" }, -- Stone Eater
        { 17215682, "194" }, -- Stone Eater
        { 17215683, "195" }, -- Stone Eater
        { 17215684, "196" }, -- Stone Eater
        { 17215685, "197" }, -- Stone Eater
        { 17215686, "198" }, -- Rock Lizard
        { 17215687, "199" }, -- Rock Lizard
        { 17215688, "200" }, -- Walking Sapling
        { 17215689, "201" }, -- Walking Sapling
        { 17215690, "202" }, -- Vulture
        { 17215691, "203" }, -- Vulture
        { 17215692, "204" }, -- Young Quadav
        { 17215693, "205" }, -- Young Quadav
        { 17215694, "206" }, -- Amethyst Quadav
        { 17215695, "207" }, -- Amber Quadav
        { 17215696, "208" }, -- Young Quadav
        { 17215697, "209" }, -- Amethyst Quadav
        { 17215698, "210" }, -- Amber Quadav
        { 17215699, "211" }, -- Stone Eater
        { 17215700, "212" }, -- Stone Eater
        { 17215701, "213" }, -- Stone Eater
        { 17215702, "214" }, -- Stone Eater
        { 17215703, "215" }, -- Stone Eater
        { 17215704, "216" }, -- Stone Eater
        { 17215705, "217" }, -- Stone Eater
        { 17215706, "218" }, -- Stone Eater
        { 17215707, "219" }, -- Rock Lizard
        { 17215708, "220" }, -- Rock Lizard
        { 17215709, "221" }, -- Walking Sapling
        { 17215710, "222" }, -- Walking Sapling
        { 17215711, "223" }, -- Vulture
        { 17215712, "224" }, -- Vulture
        { 17215713, "225" }, -- Young Quadav
        { 17215714, "226" }, -- Young Quadav
        { 17215715, "227" }, -- Amber Quadav
        { 17215716, "228" }, -- Stone Eater
        { 17215717, "229" }, -- Stone Eater
        { 17215718, "230" }, -- Stone Eater
        { 17215719, "231" }, -- Stone Eater
        { 17215720, "232" }, -- Stone Eater
        { 17215721, "233" }, -- Stone Eater
        { 17215722, "234" }, -- Walking Sapling
        { 17215723, "235" }, -- Vulture
        { 17215724, "236" }, -- Vulture
        { 17215725, "237" }, -- Goblin Thug
        { 17215726, "238" }, -- Goblin Fisher
        { 17215727, "239" }, -- Goblin Fisher
        { 17215728, "240" }, -- Stone Eater
        { 17215729, "241" }, -- Stone Eater
        { 17215730, "242" }, -- Stone Eater
        { 17215731, "243" }, -- Stone Eater
        { 17215732, "244" }, -- Stone Eater
        { 17215733, "245" }, -- Stone Eater
        { 17215734, "246" }, -- Stone Eater
        { 17215735, "247" }, -- Stone Eater
        { 17215736, "248" }, -- Walking Sapling
        { 17215737, "249" }, -- Walking Sapling
        { 17215738, "250" }, -- Vulture
        { 17215739, "251" }, -- Vulture
        { 17215740, "252" }, -- Vulture
        { 17215741, "253" }, -- Goblin Weaver
        { 17215742, "254" }, -- Goblin Fisher
        { 17215743, "255" }, -- Goblin Fisher
        { 17215744, "256" }, -- Stone Eater
        { 17215745, "257" }, -- Stone Eater
        { 17215746, "258" }, -- Stone Eater
        { 17215747, "259" }, -- Rock Lizard
        { 17215748, "260" }, -- Rock Lizard
        { 17215749, "261" }, -- Walking Sapling
        { 17215750, "262" }, -- Walking Sapling
        { 17215751, "263" }, -- Walking Sapling
        { 17215752, "264" }, -- Walking Sapling
        { 17215753, "265" }, -- Walking Sapling
        { 17215754, "266" }, -- Walking Sapling
        { 17215755, "267" }, -- Vulture
        { 17215756, "268" }, -- Vulture
        { 17215757, "269" }, -- Young Quadav
        { 17215758, "270" }, -- Amethyst Quadav
        { 17215759, "271" }, -- Amber Quadav
        { 17215760, "272" }, -- Enchanted Bones
        { 17215761, "273" }, -- Shrapnel
        { 17215762, "274" }, -- Stone Eater
        { 17215763, "275" }, -- Stone Eater
        { 17215764, "276" }, -- Rock Lizard
        { 17215765, "277" }, -- Rock Lizard
        { 17215766, "278" }, -- Walking Sapling
        { 17215767, "279" }, -- Walking Sapling
        { 17215768, "280" }, -- Walking Sapling
        { 17215769, "281" }, -- Walking Sapling
        { 17215770, "282" }, -- Walking Sapling
        { 17215771, "283" }, -- Walking Sapling
        { 17215772, "284" }, -- Vulture
        { 17215773, "285" }, -- Vulture
        { 17215774, "286" }, -- Young Quadav
        { 17215775, "287" }, -- Amethyst Quadav
        { 17215776, "288" }, -- Amber Quadav
        { 17215777, "289" }, -- Enchanted Bones
        { 17215778, "290" }, -- Tococo
        { 17215779, "291" }, -- Ornery Sheep
        { 17215780, "292" }, -- Ornery Sheep
        { 17215781, "293" }, -- Goblin Thug
        { 17215782, "294" }, -- Goblin Thug
        { 17215783, "295" }, -- Goblin Weaver
        { 17215784, "296" }, -- Goblin Weaver
        { 17215785, "297" }, -- Enchanted Bones
        { 17215786, "298" }, -- Enchanted Bones
        { 17215787, "299" }, -- Goblin Thug
        { 17215788, "300" }, -- Goblin Weaver
        { 17215789, "301" }, -- Goblin Weaver
        { 17215790, "302" }, -- Stone Eater
        { 17215791, "303" }, -- Stone Eater
        { 17215792, "304" }, -- Rock Lizard
        { 17215793, "305" }, -- Rock Lizard
        { 17215794, "306" }, -- Walking Sapling
        { 17215795, "307" }, -- Walking Sapling
        { 17215796, "308" }, -- Vulture
        { 17215797, "309" }, -- Vulture
        { 17215798, "310" }, -- Vulture
        { 17215799, "311" }, -- Vulture
        { 17215800, "312" }, -- Vulture
        { 17215801, "313" }, -- Vulture
        { 17215802, "314" }, -- Young Quadav
        { 17215803, "315" }, -- Young Quadav
        { 17215804, "316" }, -- Amethyst Quadav
        { 17215805, "317" }, -- Enchanted Bones
        { 17215806, "318" }, -- Shrapnel
        { 17215807, "319" }, -- Stone Eater
        { 17215808, "320" }, -- Stone Eater
        { 17215809, "321" }, -- Rock Lizard
        { 17215810, "322" }, -- Rock Lizard
        { 17215811, "323" }, -- Walking Sapling
        { 17215812, "324" }, -- Walking Sapling
        { 17215813, "325" }, -- Vulture
        { 17215814, "326" }, -- Vulture
        { 17215815, "327" }, -- Vulture
        { 17215816, "328" }, -- Vulture
        { 17215817, "329" }, -- Vulture
        { 17215818, "330" }, -- Vulture
        { 17215819, "331" }, -- Young Quadav
        { 17215820, "332" }, -- Young Quadav
        { 17215821, "333" }, -- Amber Quadav
        { 17215822, "334" }, -- Enchanted Bones
        { 17215823, "335" }, -- Shrapnel
        { 17215824, "336" }, -- Stone Eater
        { 17215825, "337" }, -- Stone Eater
        { 17215826, "338" }, -- Rock Lizard
        { 17215827, "339" }, -- Rock Lizard
        { 17215828, "340" }, -- Walking Sapling
        { 17215829, "341" }, -- Walking Sapling
        { 17215830, "342" }, -- Walking Sapling
        { 17215831, "343" }, -- Walking Sapling
        { 17215832, "344" }, -- Walking Sapling
        { 17215833, "345" }, -- Walking Sapling
        { 17215834, "346" }, -- Walking Sapling
        { 17215835, "347" }, -- Walking Sapling
        { 17215836, "348" }, -- Vulture
        { 17215837, "349" }, -- Vulture
        { 17215838, "350" }, -- Young Quadav
        { 17215839, "351" }, -- Young Quadav
        { 17215840, "352" }, -- Amethyst Quadav
        { 17215841, "353" }, -- Amber Quadav
        { 17215842, "354" }, -- Enchanted Bones
        { 17215843, "355" }, -- Shrapnel
        { 17215844, "356" }, -- Young Quadav
        { 17215845, "357" }, -- Amethyst Quadav
        { 17215846, "358" }, -- Amber Quadav
        { 17215847, "359" }, -- Stone Eater
        { 17215848, "360" }, -- Stone Eater
        { 17215849, "361" }, -- Rock Lizard
        { 17215850, "362" }, -- Rock Lizard
        { 17215851, "363" }, -- Walking Sapling
        { 17215852, "364" }, -- Walking Sapling
        { 17215853, "365" }, -- Walking Sapling
        { 17215854, "366" }, -- Walking Sapling
        { 17215855, "367" }, -- Walking Sapling
        { 17215856, "368" }, -- Vulture
        { 17215857, "369" }, -- Vulture
        { 17215858, "370" }, -- Young Quadav
        { 17215859, "371" }, -- Amethyst Quadav
        { 17215860, "372" }, -- Amber Quadav
        { 17215861, "373" }, -- Enchanted Bones
        { 17215862, "374" }, -- Shrapnel
        { 17215863, "375" }, -- Rock Lizard
        { 17215864, "376" }, -- Rock Lizard
        { 17215865, "377" }, -- Rock Lizard
        { 17215866, "378" }, -- Rock Lizard
        { 17215867, "379" }, -- Rock Lizard
        { 17215868, "380" }, -- Leaping Lizzy
        { 17215869, "381" }, -- Walking Sapling
        { 17215870, "382" }, -- Walking Sapling
        { 17215871, "383" }, -- Walking Sapling
        { 17215872, "384" }, -- Vulture
        { 17215873, "385" }, -- Vulture
        { 17215874, "386" }, -- Vulture
        { 17215875, "387" }, -- Young Quadav
        { 17215876, "388" }, -- Amethyst Quadav
        { 17215877, "389" }, -- Amber Quadav
        { 17215878, "390" }, -- Amber Quadav
        { 17215879, "391" }, -- Enchanted Bones
        { 17215880, "392" }, -- Young Quadav
        { 17215881, "393" }, -- Amethyst Quadav
        { 17215882, "394" }, -- Amber Quadav
        { 17215883, "395" }, -- Rock Lizard
        { 17215884, "396" }, -- Rock Lizard
        { 17215885, "397" }, -- Rock Lizard
        { 17215886, "398" }, -- Rock Lizard
        { 17215887, "399" }, -- Rock Lizard
        { 17215888, "400" }, -- Leaping Lizzy
        { 17215889, "401" }, -- Walking Sapling
        { 17215890, "402" }, -- Walking Sapling
        { 17215891, "403" }, -- Walking Sapling
        { 17215892, "404" }, -- Vulture
        { 17215893, "405" }, -- Vulture
        { 17215894, "406" }, -- Vulture
        { 17215895, "407" }, -- Young Quadav
        { 17215896, "408" }, -- Young Quadav
        { 17215897, "409" }, -- Amber Quadav
        { 17215898, "410" }, -- Enchanted Bones
        { 17215899, "411" }, -- Rock Lizard
        { 17215900, "412" }, -- Rock Lizard
        { 17215901, "413" }, -- Rock Lizard
        { 17215902, "414" }, -- Rock Lizard
        { 17215903, "415" }, -- Rock Lizard
        { 17215904, "416" }, -- Walking Sapling
        { 17215905, "417" }, -- Walking Sapling
        { 17215906, "418" }, -- Walking Sapling
        { 17215907, "419" }, -- Vulture
        { 17215908, "420" }, -- Vulture
        { 17215909, "421" }, -- Vulture
        { 17215910, "422" }, -- Young Quadav
        { 17215911, "423" }, -- Young Quadav
        { 17215912, "424" }, -- Amethyst Quadav
        { 17215913, "425" }, -- Enchanted Bones
        { 17215914, "426" }, -- Maneating Hornet
        { 17215915, "427" }, -- Maneating Hornet
        { 17215916, "428" }, -- Maneating Hornet
        { 17215917, "429" }, -- Maneating Hornet
        { 17215918, "430" }, -- Maneating Hornet
        { 17215919, "431" }, -- Maneating Hornet
        { 17215920, "432" }, -- Land Crab
        { 17215921, "433" }, -- Land Crab
        { 17215922, "434" }, -- Land Crab
        { 17215923, "435" }, -- Land Crab
        { 17215924, "436" }, -- Land Crab
        { 17215925, "437" }, -- Land Crab
        { 17215926, "438" }, -- Land Crab
        { 17215927, "439" }, -- Land Crab
        { 17215928, "440" }, -- Goblin Thug
        { 17215929, "441" }, -- Goblin Weaver
        { 17215930, "442" }, -- Shrapnel
        { 17215931, "443" }, -- Maneating Hornet
        { 17215932, "444" }, -- Maneating Hornet
        { 17215933, "445" }, -- Maneating Hornet
        { 17215934, "446" }, -- Maneating Hornet
        { 17215935, "447" }, -- Maneating Hornet
        { 17215936, "448" }, -- Maneating Hornet
        { 17215937, "449" }, -- Land Crab
        { 17215938, "450" }, -- Land Crab
        { 17215939, "451" }, -- Land Crab
        { 17215940, "452" }, -- Land Crab
        { 17215941, "453" }, -- Land Crab
        { 17215942, "454" }, -- Land Crab
        { 17215943, "455" }, -- Land Crab
        { 17215944, "456" }, -- Land Crab
        { 17215945, "457" }, -- Goblin Thug
        { 17215946, "458" }, -- Goblin Weaver
        { 17215947, "459" }, -- Shrapnel
        { 17215948, "460" }, -- Goblin Digger
        { 17215949, "461" }, -- Pixie
        { 17215950, "462" }, -- Pixie
        { 17215951, "463" }, -- Pixie
        { 17215952, "464" }, -- Pixie
        { 17215953, "465" }, -- Pixie
        { 17215954, "466" }, -- Grylio
        { 17215955, "467" }, -- Bhishani
        { 17215956, "468" }, -- Bhishani
        { 17215957, "469" }, -- Bhishani
        { 17215958, "470" }, -- Goblin Rider
        { 17215959, "471" }, -- Overturned Soil
        { 17215960, "472" }, -- Overturned Soil
        { 17215961, "473" }, -- Overturned Soil
        { 17215962, "474" }, -- Overturned Soil
        { 17215963, "475" }, -- Overturned Soil
        { 17215964, "476" }, -- Overturned Soil
        { 17215965, "477" }, -- Overturned Soil
        { 17215966, "478" }, -- Overturned Soil
        { 17215967, "479" }, -- Wayward Worm
        { 17215968, "480" }, -- Wayward Worm
        { 17215969, "481" }, -- Wayward Worm
        { 17215970, "482" }, -- Fablinix
        { 17215971, "483" }, -- Overturned Soil
        { 17215972, "484" }, -- Overturned Soil
        { 17215973, "485" }, -- Overturned Soil
        { 17215974, "486" }, -- Overturned Soil
        { 17215975, "487" }, -- Overturned Soil
        { 17215976, "488" }, -- Overturned Soil
        { 17215977, "489" }, -- Overturned Soil
        { 17215978, "490" }, -- Overturned Soil
        { 17215979, "491" }, -- Wayward Worm
        { 17215980, "492" }, -- Wayward Worm
        { 17215981, "493" }, -- Wayward Worm
        { 17215982, "494" }, -- Goblin Rider
        { 17215983, "495" }, -- Overturned Soil
        { 17215984, "496" }, -- Overturned Soil
        { 17215985, "497" }, -- Overturned Soil
        { 17215986, "498" }, -- Overturned Soil
        { 17215987, "499" }, -- Overturned Soil
        { 17215988, "500" }, -- Overturned Soil
        { 17215989, "501" }, -- Overturned Soil
        { 17215990, "502" }, -- Overturned Soil
        { 17215991, "503" }, -- Wayward Worm
        { 17215992, "504" }, -- Wayward Worm
        { 17215993, "505" }, -- Wayward Worm
        { 17215994, "506" }, -- Tatenashi Armor
        { 17215995, "507" }, -- Hizamaru Armor
        { 17215996, "508" }, -- Ubuginu Armor
        { 17215997, "509" }, -- Hachiryu Armor
        { 17215998, "510" }, -- Omodaka Armor
        { 17215999, "511" }, -- Bull [Herd1]
        { 17216000, "512" }, -- Cow [Herd1]
        { 17216001, "513" }, -- Cow [Herd1]
        { 17216002, "514" }, -- Cow [Herd1]
        { 17216003, "515" }, -- Calf [Herd1]
        { 17216004, "516" }, -- Calf [Herd1]
        { 17216005, "517" }, -- Calf [Herd1]
        { 17216006, "518" }, -- Calf [Herd1]
        { 17216007, "519" }, -- Calf [Herd1]
        { 17216008, "520" }, -- Calf [Herd1]
        { 17216009, "521" }, -- Bull [Herd2]
        { 17216010, "522" }, -- Cow [Herd2]
        { 17216011, "523" }, -- Cow [Herd2]
        { 17216012, "524" }, -- Cow [Herd2]
        { 17216013, "525" }, -- Calf [Herd2]
        { 17216014, "526" }, -- Calf [Herd2]
        { 17216015, "527" }, -- Calf [Herd2]
        { 17216016, "528" }, -- Calf [Herd2]
        { 17216017, "529" }, -- Calf [Herd2]
        { 17216018, "530" }, -- Calf [Herd2]
        { 17216019, "531" }, -- Bull [Herd3]
        { 17216020, "532" }, -- Cow [Herd3]
        { 17216021, "533" }, -- Cow [Herd3]
        { 17216022, "534" }, -- Cow [Herd3]
        { 17216023, "535" }, -- Calf [Herd3]
        { 17216024, "536" }, -- Calf [Herd3]
        { 17216025, "537" }, -- Calf [Herd3]
        { 17216026, "538" }, -- Calf [Herd3]
        { 17216027, "539" }, -- Calf [Herd3]
        { 17216028, "540" }, -- Calf [Herd3]
        { 17216029, "541" }, -- Chigoe
        { 17216030, "542" }, -- Chigoe
        { 17216031, "543" }, -- Chigoe
        { 17216032, "544" }, -- Chigoe
        { 17216033, "545" }, -- Chigoe
        { 17216034, "546" }, -- Chigoe
        { 17216035, "547" }, -- Chigoe
        { 17216036, "548" }, -- Chigoe
        { 17216037, "549" }, -- Chigoe
        { 17216038, "550" }, -- Chigoe
        { 17216039, "551" }, -- Pyracmon
        { 17216040, "552" }, -- Wraith Bat
        { 17216041, "553" }, -- Wraith Bat
        { 17216042, "554" }, -- Wraith Bat
        { 17216043, "555" }, -- Wraith Bat
        { 17216044, "556" }, -- Wraith Bat
        { 17216045, "557" }, -- Wraith Bat
        { 17216046, "558" }, -- Wraith Bat
        { 17216047, "559" }, -- Wraith Bat
        { 17216048, "560" }, -- Wraith Bat
        { 17216049, "561" }, -- Wraith Bat
        { 17216050, "562" }, -- Astral Box
        { 17216051, "563" }, -- Astral Box
        { 17216052, "564" }, -- Astral Box
        { 17216053, "565" }, -- Astral Box
        { 17216054, "566" }, -- Astral Box
        { 17216055, "567" }, -- Astral Box
        { 17216056, "568" }, -- Astral Box
        { 17216057, "569" }, -- Astral Box
        { 17216058, "570" }, -- Astral Box
        { 17216059, "571" }, -- Astral Box
        { 17216060, "572" }, -- Astral Box
        { 17216061, "573" }, -- Astral Box
        { 17216062, "574" }, -- Astral Box
        { 17216063, "575" }, -- Astral Box
        { 17216064, "576" }, -- Astral Box
        { 17216065, "577" }, -- Astral Box
        { 17216066, "578" }, -- Astral Box
        { 17216067, "579" }, -- Astral Box
        { 17216068, "580" }, -- Astral Box
        { 17216069, "581" }, -- Astral Box
        { 17216070, "582" }, -- Astral Box
        { 17216071, "583" }, -- Astral Box
        { 17216072, "584" }, -- Astral Box
        { 17216073, "585" }, -- Astral Box
        { 17216074, "586" }, -- Astral Box
        { 17216075, "587" }, -- Astral Box
        { 17216076, "588" }, -- Astral Box
        { 17216077, "589" }, -- Astral Box
        { 17216078, "590" }, -- Astral Box
        { 17216079, "591" }, -- Astral Box
        { 17216080, "592" }, -- Astral Box
        { 17216081, "593" }, -- Astral Box
        { 17216082, "594" }, -- Astral Box
        { 17216083, "595" }, -- Astral Box
        { 17216084, "596" }, -- Astral Box
        { 17216085, "597" }, -- Astral Box
        { 17216086, "598" }, -- Astral Box
        { 17216087, "599" }, -- Astral Box
        { 17216088, "600" }, -- Astral Box
        { 17216089, "601" }, -- Astral Box
        { 17216090, "602" }, -- Astral Box
        { 17216091, "603" }, -- Astral Box
        { 17216092, "604" }, -- Slime
        { 17216093, "605" }, -- Slime
        { 17216094, "606" }, -- Slime
        { 17216095, "607" }, -- Slime
        { 17216096, "608" }, -- Slime
        { 17216097, "609" }, -- Slime
        { 17216098, "610" }, -- Slime
        { 17216099, "611" }, -- Slime
        { 17216100, "612" }, -- Slime
        { 17216101, "613" }, -- Slime
        { 17216102, "614" }, -- Slime
        { 17216103, "615" }, -- Slime
        { 17216104, "616" }, -- Slime
        { 17216105, "617" }, -- Slime
        { 17216106, "618" }, -- Slime
        { 17216107, "619" }, -- Slime
        { 17216108, "620" }, -- Slime
        { 17216109, "621" }, -- Slime
        { 17216110, "622" }, -- Slime
        { 17216111, "623" }, -- Slime
        { 17216112, "624" }, -- She-Slime
        { 17216113, "625" }, -- She-Slime
        { 17216114, "626" }, -- She-Slime
        { 17216115, "627" }, -- She-Slime
        { 17216116, "628" }, -- She-Slime
        { 17216117, "629" }, -- She-Slime
        { 17216118, "630" }, -- She-Slime
        { 17216119, "631" }, -- She-Slime
        { 17216120, "632" }, -- She-Slime
        { 17216121, "633" }, -- She-Slime
        { 17216122, "634" }, -- Metal Slime
        { 17216123, "635" }, -- Metal Slime
        { 17216124, "636" }, -- Metal Slime
        { 17216125, "637" }, -- Metal Slime
        { 17216126, "638" }, -- Metal Slime
        { 17216127, "639" }, -- Bounding Belinda
        { 17216128, "640" }, -- Bounding Belinda
        { 17216129, "641" }, -- Bounding Belinda
        { 17216130, "642" }, -- Fortuitous Mandrill
        { 17216131, "643" }, -- Fortuitous Macaque
        { 17216132, "644" }, -- Fortuitous Bekantan
        { 17216133, "645" }, -- Fortuitous Howler
        { 17216134, "646" }, -- Fortuitous Marmoset
        { 17216135, "647" }, -- Moogle
        { 17216136, "648" }, -- Ornery Crab
        { 17216137, "649" }, -- Ornery Crab
        { 17216138, "650" }, -- Ornery Crab
        { 17216139, "651" }, -- Ornery Crab
        { 17216140, "652" }, -- Ornery Crab
        { 17216141, "653" }, -- Ornery Crab
        { 17216142, "654" }, -- Ornery Crab
        { 17216143, "655" }, -- Ornery Crab
        { 17216144, "656" }, -- Ornery Crab
        { 17216145, "657" }, -- Ornery Crab
        { 17216146, "658" }, -- Ornery Crab
        { 17216147, "659" }, -- Ornery Crab
        { 17216148, "660" }, -- Ornery Crab
        { 17216149, "661" }, -- Ornery Crab
        { 17216150, "662" }, -- Vexed Crab
        { 17216151, "663" }, -- Vexed Crab
        { 17216152, "664" }, -- Vexed Crab
        { 17216153, "665" }, -- Vexed Crab
        { 17216154, "666" }, -- Vexed Crab
        { 17216155, "667" }, -- Vexed Crab
        { 17216156, "668" }, -- Vexed Crab
        { 17216157, "669" }, -- Vexed Crab
        { 17216158, "670" }, -- Vexed Crab
        { 17216159, "671" }, -- Vexed Crab
        { 17216160, "672" }, -- Vexed Crab
        { 17216161, "673" }, -- Vexed Crab
        { 17216162, "674" }, -- Vexed Crab
        { 17216163, "675" }, -- Vexed Crab
        { 17216164, "676" }, -- Crab King
        { 17216165, "677" }, -- Crab Czar
        { 17216166, "678" }, -- skipped
        { 17216167, "679" }, -- skipped
        { 17216168, "680" }, -- skipped
        { 17216169, "681" }, -- skipped
        { 17216170, "682" }, -- skipped
        { 17216171, "683" }, -- Treasure Casket
        { 17216172, "684" }, -- Treasure Casket
        { 17216173, "685" }, -- Treasure Casket
        { 17216174, "686" }, -- Treasure Casket
        { 17216175, "687" }, -- Treasure Casket
        { 17216176, "688" }, -- Treasure Casket
        { 17216177, "689" }, -- Treasure Casket
        { 17216178, "690" }, -- Treasure Casket
        { 17216179, "691" }, -- Treasure Casket
        { 17216180, "692" }, -- Treasure Casket
        { 17216181, "693" }, -- Treasure Casket
        { 17216182, "694" }, -- Treasure Casket
        { 17216183, "695" }, -- Treasure Casket
        { 17216184, "696" }, -- Treasure Casket
        { 17216185, "697" }, -- Treasure Casket
        { 17216186, "698" }, -- Treasure Casket
        { 17216187, "699" }, -- Treasure Coffer
        { 17216188, "700" }, -- Achieve Master
        { 17216189, "701" }, -- Unity Master
        { 17216190, "702" }, -- skipped
        { 17216191, "703" }, -- skipped
        { 17216192, "704" }, -- skipped
        { 17216193, "705" }, -- skipped
        { 17216194, "706" }, -- skipped
        { 17216195, "707" }, -- Moogle
        { 17216196, "708" }, -- Moogle
        { 17216197, "709" }, -- Moogle
        { 17216198, "710" }, -- Moogle
        { 17216199, "711" }, -- ???
        { 17216200, "712" }, -- ???
        { 17216201, "713" }, -- Stone Monument
        { 17216202, "714" }, -- skipped
        { 17216203, "715" }, -- blank
        { 17216204, "716" }, -- EFFECTER
        { 17216205, "717" }, -- Carbuncle
        { 17216206, "718" }, -- Talking Doll
        { 17216207, "719" }, -- Ramblix
        { 17216208, "720" }, -- Goblin Footprint
        { 17216209, "721" }, -- blank
        { 17216210, "722" }, -- Prishe
        { 17216211, "723" }, -- Azette
        { 17216212, "724" }, -- blank
        { 17216213, "725" }, -- Field Manual
        { 17216214, "726" }, -- Field Manual
        { 17216215, "727" }, -- Field Parchment
        { 17216216, "728" }, -- Ethereal Junction
        { 17216217, "729" }, -- Ethereal Junction
        { 17216218, "730" }, -- Ethereal Junction
        { 17216219, "731" }, -- Mogball-Local
        { 17216220, "732" }, -- Mog-Tablet
        { 17216221, "733" }, -- Planar Rift
        { 17216222, "734" }, -- Planar Rift
        { 17216223, "735" }, -- Planar Rift
        { 17216224, "736" }, -- Riftworn Pyxis
        { 17216225, "737" }, -- Riftworn Pyxis
        { 17216226, "738" }, -- Riftworn Pyxis
        { 17216227, "739" }, -- Cavernous Maw
        { 17216228, "740" }, -- Moogle
        { 17216229, "741" }, -- ???
        { 17216230, "742" }, -- ???
        { 17216231, "743" }, -- ???
        { 17216232, "744" }, -- ???
        { 17216233, "745" }, -- ???
        { 17216234, "746" }, -- blank
        { 17216235, "747" }, -- Moogle
        { 17216236, "748" }, -- skipped
        { 17216237, "749" }, -- skipped
        { 17216238, "750" }, -- skipped
        { 17216239, "751" }, -- skipped
        { 17216240, "752" }, -- skipped
        { 17216241, "753" }, -- skipped
        { 17216242, "754" }, -- skipped
        { 17216243, "755" }, -- skipped
        { 17216244, "756" }, -- skipped
        { 17216245, "757" }, -- skipped
        { 17216246, "758" }, -- skipped
        { 17216247, "759" }, -- skipped
        { 17216248, "760" }, -- skipped
        { 17216249, "761" }, -- skipped
        { 17216250, "762" }, -- skipped
        { 17216251, "763" }, -- skipped
        { 17216252, "764" }, -- skipped
        { 17216253, "765" }, -- skipped
        { 17216254, "766" }, -- skipped
        { 17216255, "767" }, -- skipped
        { 17216256, "768" }, -- skipped
        { 17216257, "769" }, -- skipped
        { 17216258, "770" }, -- skipped
        { 17216259, "771" }, -- skipped
        { 17216260, "772" }, -- skipped
        { 17216261, "773" }, -- skipped
        { 17216262, "774" }, -- skipped
        { 17216263, "775" }, -- skipped
        { 17216264, "776" }, -- skipped
        { 17216265, "777" }, -- skipped
        { 17216266, "778" }, -- blank
        { 17216267, "779" }, -- Fish Eyes
        { 17216268, "780" }, -- skipped
        { 17216269, "781" }, -- Moogle
        { 17216270, "782" }, -- Moogle
        { 17216271, "783" }, -- Moogle
        { 17216272, "784" }, -- ???
        { 17216273, "785" }, -- Magivore Ternion
        { 17216274, "786" }, -- Wandering Cloud
        { 17216275, "787" }, -- Smile Helper
        { 17216276, "788" }, -- Smile Helper
        { 17216277, "789" }, -- Smile Helper
        { 17216278, "790" }, -- Smile Helper
        { 17216279, "791" }, -- Smile Helper
        { 17216280, "792" }, -- Smile Helper
        { 17216281, "793" }, -- Smile Helper
        { 17216282, "794" }, -- Smile Helper
        { 17216283, "795" }, -- Smile Helper
        { 17216284, "796" }, -- Smile Helper
        { 17216285, "797" }, -- Debug
        { 17216286, "798" }, -- blank
        { 17216287, "799" }, -- Slime Tarou
        { 17216288, "800" }, -- blank
        { 17216289, "801" }, -- blank
        { 17216290, "802" }, -- Orgis
        { 17216291, "803" }, -- blank
        { 17216292, "804" }, -- ???
        { 17216293, "805" }, -- blank
        { 17216511, "1023" },
    },
}
return list
