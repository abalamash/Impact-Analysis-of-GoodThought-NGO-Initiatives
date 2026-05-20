SELECT public.assignments.assignment_name, public.assignments.region, ROUND(SUM(public.donations.amount),2) AS rounded_total_donation_amount, public.donors.donor_type
FROM public.assignments 
INNER JOIN public.donations
	ON public.assignments.assignment_id = public.donations.assignment_id
INNER JOIN public.donors
	ON  public.donations.donor_id = public.donors.donor_id
GROUP BY public.donors.donor_type, public.assignments.assignment_name, public.assignments.region
ORDER BY rounded_total_donation_amount DESC
LIMIT 5;
