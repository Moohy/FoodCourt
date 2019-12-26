module RestaurantsHelper
    def cities city
        @cities = Branch.joins(:restaurant).select(:city).where(restaurants: {name: city}).group(:city)
    end
end
