module RestaurantsHelper
    def cities city
        
        # links = []
        @cities = Branch.joins(:restaurant).select(:city).where(restaurants: {name: city})
        # links
    end
end
