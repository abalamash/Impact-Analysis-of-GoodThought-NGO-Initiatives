WITH top_four_rank AS (
	SELECT  DISTINCT public.assignments.assignment_name ,   public.assignments.region, public.assignments.impact_score , 
DENSE_RANK() OVER(PARTITION BY  public.assignments.region ORDER BY public.assignments.impact_score DESC) AS rank_number
FROM public.assignments 
INNER JOIN public.donations
	ON public.assignments.assignment_id = public.donations.assignment_id
INNER JOIN public.donors
	ON public.donations.donor_id = public.donors.donor_id
ORDER BY  rank_number, public.assignments.region  
LIMIT 4
)

	
SELECT  DISTINCT public.assignments.assignment_name ,   public.assignments.region, public.assignments.impact_score , 
SUM(public.donations.amount) OVER(PARTITION BY  public.assignments.region) AS num_total_donations 
FROM public.assignments 
INNER JOIN public.donations
	ON public.assignments.assignment_id = public.donations.assignment_id
INNER JOIN public.donors
	ON public.donations.donor_id = public.donors.donor_id
WHERE  public.assignments.assignment_name IN (SELECT assignment_name FROM top_four_rank )
ORDER BY  public.assignments.region;
