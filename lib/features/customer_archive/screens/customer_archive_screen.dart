import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/customer.dart';
import '../providers/customer_archive_provider.dart';

class CustomerArchiveScreen extends StatelessWidget {
  const CustomerArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerArchiveProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            Expanded(flex: 5, child: _ArchiveList(provider: provider)),
            const SizedBox(width: 18),
            Expanded(
              flex: 4,
              child: _CustomerDetail(
                customer: provider.selected,
                loading: provider.loading,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ArchiveList extends StatelessWidget {
  const _ArchiveList({required this.provider});

  final CustomerArchiveProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.folder_shared_outlined,
                  color: Color(0xFFD4A64A),
                ),
                const SizedBox(width: 10),
                const Text(
                  'CUSTOMER ARCHIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'New customer',
                  onPressed: provider.createDemoCustomer,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 14),
            TextField(
              onChanged: provider.search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search archive',
                filled: true,
                fillColor: Color(0xFF1F2937),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: provider.loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: provider.customers.length,
                      itemBuilder: (context, index) {
                        final customer = provider.customers[index];
                        final active = provider.selected?.id == customer.id;

                        return _CustomerTile(
                          customer: customer,
                          active: active,
                          onTap: () => provider.select(customer),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomerTile extends StatelessWidget {
  const _CustomerTile({
    required this.customer,
    required this.active,
    required this.onTap,
  });

  final Customer customer;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF24324A) : const Color(0xFF182232),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: active ? const Color(0xFFD4A64A) : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF0F172A),
              child: Text(
                customer.firstName.isEmpty
                    ? '?'
                    : customer.firstName[0].toUpperCase(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.fullName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${customer.countryCode} • ${customer.documentType}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              customer.jobCount.toString(),
              style: const TextStyle(
                color: Color(0xFF34D399),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomerDetail extends StatelessWidget {
  const _CustomerDetail({required this.customer, required this.loading});

  final Customer? customer;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final selected = customer;

    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: selected == null
            ? const Center(
                child: Text(
                  'No customer selected',
                  style: TextStyle(color: Colors.white54),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.badge_outlined,
                        color: Color(0xFF65B9FF),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          selected.fullName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Delete customer',
                        onPressed: loading
                            ? null
                            : context
                                  .read<CustomerArchiveProvider>()
                                  .deleteSelected,
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _DetailRow(label: 'Document', value: selected.documentNumber),
                  _DetailRow(label: 'Country', value: selected.countryCode),
                  _DetailRow(label: 'Type', value: selected.documentType),
                  _DetailRow(
                    label: 'Jobs',
                    value: selected.jobCount.toString(),
                  ),
                  _DetailRow(
                    label: 'Last job',
                    value:
                        selected.lastJobAt
                            ?.toLocal()
                            .toString()
                            .split('.')
                            .first ??
                        'Not processed',
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0x22FFFFFF)),
                      ),
                      child: Text(
                        selected.notes ?? 'Archive record ready',
                        style: const TextStyle(
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 94,
            child: Text(label, style: const TextStyle(color: Colors.white54)),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _panelDecoration() {
  return BoxDecoration(
    color: const Color(0xFF111827),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: const Color.fromRGBO(255, 255, 255, .06)),
  );
}
