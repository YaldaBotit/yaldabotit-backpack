config = {}

config.FrameworkResource = 'qb-core' --Name of your qb-core resource
config.InvType = 'qb' --The type of inventory youre using (qb,ox)
config.InvName = 'qb-inventory' --The name of your qb-inventory resource (qb-inventory,lj-inventory,ox_inventory,etc...)

config.Bags = {
    {ClothingMaleID = 82, MaleTextureID = 0,  ClothingFemaleID = 82, FemaleTextureID = 0, InsideWeight = 50000, Slots = 10, Item = 'duffle1'},
    {ClothingMaleID = 82, MaleTextureID = 6,  ClothingFemaleID = 82, FemaleTextureID = 6, InsideWeight = 50000, Slots = 10, Item = 'duffle2'},
}