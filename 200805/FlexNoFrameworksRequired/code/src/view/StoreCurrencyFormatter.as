package view
{
	import mx.formatters.CurrencyFormatter;

	/**
	 * Custom currency formatter. In a more mature implementation
	 * it might support localization, but we don't care about that
	 * for this demo. 
	 */
	public class StoreCurrencyFormatter extends CurrencyFormatter
	{
		public function StoreCurrencyFormatter()
		{
			super();
		
			currencySymbol = "$";
			precision = 2;
		}
	}
}